import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _controller.text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    Provider.of<ChatProvider>(context, listen: false).addMessage(_controller.text, true, context);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<ChatProvider>(
            builder: (context, chatProvider, child) {
              final isLoading = chatProvider.isLoading;
              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: chatProvider.messages.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (isLoading && index == 0) {
                    // Typing Indicator (Bot side) with Avatar
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildAvatar(isUser: false),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF14303B), // Dark Teal/Grey for Bot
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                                bottomLeft: Radius.zero, // Tail effect
                              ),
                            ),
                            child: const Text(
                              "Typing...",
                              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final msg = chatProvider.messages[isLoading ? index - 1 : index];
                  final isUser = msg.isUser;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!isUser) ...[_buildAvatar(isUser: false), const SizedBox(width: 8)],
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isUser ? const Color(0xFF1D4150) : const Color(0xFF14303B),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: const Radius.circular(16),
                                bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
                                bottomRight: isUser ? Radius.zero : const Radius.circular(16),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MarkdownBody(
                                  data: msg.text,
                                  styleSheet: MarkdownStyleSheet(
                                    p: const TextStyle(fontSize: 15, color: Colors.white),
                                    strong: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2AC6A9)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isUser) ...[const SizedBox(width: 8), _buildAvatar(isUser: true)],
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        _buildInputArea(),
      ],
    );
  }

  Widget _buildAvatar({required bool isUser}) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isUser ? const Color(0xFF1D4150) : const Color(0xFFFFD700), // Yellow for Bot
        shape: BoxShape.circle,
      ),
      child: Icon(isUser ? Icons.person : Icons.smart_toy, size: 20, color: isUser ? Colors.white : Colors.black),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: const Color(0xFF14303B), borderRadius: BorderRadius.circular(30)),
            child: IconButton(
              icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
              color: _isListening ? Colors.red : const Color(0xFF2AC6A9),
              onPressed: _listen,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: const Color(0xFF14303B), borderRadius: BorderRadius.circular(30)),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Share your thoughts...',
                  hintStyle: TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2AC6A9), // Teal Send Button
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send_rounded, color: Color(0xFF03121A), size: 20),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
