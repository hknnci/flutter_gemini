import 'package:flutter/material.dart';
import 'package:flutter_gemini/models/chatbot_service.dart';
import 'package:flutter_gemini/screens/chatbot_screen.dart';
import 'package:flutter_gemini/screens/splash_screen.dart'; // Import the splash screen
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatbotService(),
      child: MaterialApp(
        title: 'Gemini Chatbot App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/chat': (context) => const ChatScreen(),
        },
      ),
    );
  }
}
