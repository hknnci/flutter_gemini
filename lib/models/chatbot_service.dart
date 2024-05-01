import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatbotService extends ChangeNotifier {
  final GenerativeModel _generativeModel = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'AIzaSyBVA-0JKvLNKfB0gU5_km38hFk5dAbAB0M',
  );

  final List<String> _messages = [];

  List<String> get messages => _messages;

  Future<void> sendMessage(String message) async {
    _messages.add("You: $message");

    notifyListeners();

    final response = await _generativeModel.generateContent([
      Content.text(message),
    ]);

    _messages.add("Gemini: ${response.text}");

    notifyListeners();
  }
}
