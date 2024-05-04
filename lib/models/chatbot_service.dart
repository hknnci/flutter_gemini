import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatbotService extends ChangeNotifier {
  final GenerativeModel _generativeModel = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'YOUR-API-KEY',
  );

  final List<String> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _sendingMessage = false;

  List<String> get messages => _messages;
  ScrollController get scrollController => _scrollController;
  bool get sendingMessage => _sendingMessage;

  Future<void> sendMessage(String message) async {
    _messages.add("You: $message");
    _sendingMessage = true;
    notifyListeners();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    final response = await _generativeModel.generateContent([
      Content.text(message),
    ]);

    _messages.add("Gemini: ${response.text}");

    _sendingMessage = false;
    notifyListeners();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}
