import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_message_model.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  bool _isLoading = false;

  // Singleton model and chat session
  late final _model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');
  late final _chat = _model.startChat();

  ChatProvider() {
    _loadMessages();
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

    try {
      final response = await _chat.sendMessage(Content.text(userText));
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
