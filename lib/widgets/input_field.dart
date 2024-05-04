import 'package:flutter/material.dart';
import 'package:flutter_gemini/providers/chatbot_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class InputField extends StatelessWidget {
  const InputField({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff111318),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0xff111318),
            offset: Offset(3.0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color(0xFF2b2b2b),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Enter your message',
                            border: InputBorder.none,
                          ),
                          onSubmitted: (text) {
                            _sendMessage(context, controller.text);
                            controller.clear();
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _sendMessage(context, controller.text);
                        FocusScope.of(context).unfocus();
                        controller.clear();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/gemini-icon.svg',
                          height: 32,
                          width: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context, String message) {
    if (message.isNotEmpty) {
      Provider.of<ChatbotProvider>(context, listen: false).sendMessage(message);
    }
  }
}
