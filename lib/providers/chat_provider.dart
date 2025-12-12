import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_message_model.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  bool _isLoading = false;

  // Singleton model and chat session
  late final _model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
    systemInstruction: Content.system("""
You are Unify, a warm, compassionate, and friendly mental health companion. 
You are not just a bot, but a supportive friend specialized in psychology and mental well-being.
Your goal is to actively listen, validate feelings, and provide evidence-based psychological insights (CBT, mindfulness) in a conversational, easy-to-understand way.
Always respond with empathy and care. If someone is struggling, offer grounding techniques or gentle advice.
Important: If a user expresses severe crisis, self-harm, or danger, strictly and gently encourage them to seek professional help or contact emergency services immediately.
Keep your tone hopeful, non-judgmental, and deeply supportive.
"""),
  );
  ChatSession? _chat;

  ChatProvider() {
    _loadMessages();
    _restoreHistory();
  }

  // ... _loadMessages (UI) ...

  Future<void> _restoreHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyJson = prefs.getString('ai_history');

    List<Content> history = [];
    if (historyJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(historyJson);
        for (var item in decoded) {
          final role = item['role'];
          final text = item['text'];
          if (role == 'user') {
            history.add(Content.text(text));
          } else {
            history.add(Content.model([TextPart(text)]));
          }
        }
      } catch (e) {
        print("Error restoring history: $e");
      }
    }

    _chat = _model.startChat(history: history);
    notifyListeners();
  }

  Future<void> saveHistory() async {
    if (_chat == null) return;
    final prefs = await SharedPreferences.getInstance();

    // Serialize current history
    final historyList = _chat!.history.map((content) {
      // Assuming simple text parts for now
      String text = "";
      if (content.parts.isNotEmpty && content.parts.first is TextPart) {
        text = (content.parts.first as TextPart).text;
      }
      return {'role': content.role, 'text': text};
    }).toList();

    await prefs.setString('ai_history', jsonEncode(historyList));
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String? messagesJson = prefs.getString('chat_history');
    if (messagesJson != null) {
      final List<dynamic> decoded = jsonDecode(messagesJson);
      _messages = decoded.map((item) => ChatMessage.fromMap(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(_messages.map((m) => m.toMap()).toList());
    await prefs.setString('chat_history', encoded);
  }

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  void addMessage(String text, bool isUser, BuildContext context) {
    _messages.insert(0, ChatMessage(id: DateTime.now().toString(), text: text, isUser: isUser, timestamp: DateTime.now()));
    notifyListeners();
    _saveMessages();

    if (isUser) {
      _getAIResponse(text, context);
    }
  }

  Future<void> _getAIResponse(String userText, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    if (_chat == null) {
      _chat = _model.startChat();
    }

    try {
      final response = await _chat!.sendMessage(Content.text(userText));
      final botReply = response.text ?? "I'm having trouble understanding right now.";

      _messages.insert(0, ChatMessage(id: DateTime.now().toString(), text: botReply, isUser: false, timestamp: DateTime.now()));
      _saveMessages();
    } catch (e) {
      print("=======AI Error: $e");
      _messages.insert(
        0,
        ChatMessage(
          id: DateTime.now().toString(),
          text: "Sorry, I'm offline right now.",
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
      _saveMessages();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
