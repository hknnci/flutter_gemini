import 'package:flutter/material.dart';
import 'package:flutter_gemini/providers/chatbot_provider.dart';
import 'package:flutter_gemini/screens/chat_screen.dart';
import 'package:flutter_gemini/screens/splash_screen.dart';
import 'package:flutter_gemini/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatbotProvider(),
      child: MaterialApp(
        title: 'Gemini Chatbot App',
        debugShowCheckedModeBanner: false,
        theme: const AppTheme(TextTheme()).light(),
        darkTheme: const AppTheme(TextTheme()).dark(),
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/chat': (context) => const ChatScreen(),
        },
      ),
    );
  }
}
