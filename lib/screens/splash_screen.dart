import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/chat');
    });

    return Scaffold(
      body: Center(
        child: SvgPicture.asset('assets/gemini.svg'),
      ),
    );
  }
}
