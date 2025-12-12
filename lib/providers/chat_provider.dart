import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_ai/firebase_ai.dart';
import '../models/chat_message_model.dart';
import 'mental_health_provider.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  // Singleton model and chat session
  late final _model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');
  late final _chat = _model.startChat();

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  void addMessage(String text, bool isUser, BuildContext context) {
    _messages.insert(0, ChatMessage(id: DateTime.now().toString(), text: text, isUser: isUser, timestamp: DateTime.now()));
    notifyListeners();

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
    } catch (e) {
      print("AI Error: $e");
      _messages.insert(
        0,
        ChatMessage(
          id: DateTime.now().toString(),
          text: "Sorry, I'm offline right now.",
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
