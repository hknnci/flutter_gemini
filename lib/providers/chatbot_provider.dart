import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatbotProvider extends ChangeNotifier {
  final GenerativeModel _generativeModel = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'YOUR-API-KEY',
  );

  final List<String> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  bool _sendingMessage = false;

  List<String> get messages => _messages;
  ScrollController get scrollController => _scrollController;
  TextEditingController get controller => _controller;
  bool get sendingMessage => _sendingMessage;

  Future<void> sendMessage(String message) async {
    if (message.isNotEmpty) {
      _messages.add("You: $message");
      _sendingMessage = true;
      notifyListeners();
      animateScrollController();

      try {
        final response = await _generativeModel.generateContent([
          Content.text(message),
        ]);
        if (!_sendingMessage) return;
        _messages.add("Gemini: ${response.text}");
      } catch (e) {
        log('Error: $e');
      } finally {
        _sendingMessage = false;
        notifyListeners();
        animateScrollController();
      }
    }
  }

  void animateScrollController() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    });
  }

  void cancelSending() {
    _sendingMessage = false;
    notifyListeners();
  }

  void clearController() {
    _controller.clear();
    notifyListeners();
  }
}
