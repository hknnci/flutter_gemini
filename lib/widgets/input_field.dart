import 'package:flutter/material.dart';
import 'package:flutter_gemini/providers/chatbot_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class InputField extends StatelessWidget {
  const InputField({super.key});

  @override
  Widget build(BuildContext context) => Consumer<ChatbotProvider>(
        builder: (context, chatProvider, _) => Container(
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
                              controller: chatProvider.controller,
                              enabled: !chatProvider.sendingMessage,
                              decoration: const InputDecoration(
                                hintText: 'Enter your message',
                                border: InputBorder.none,
                              ),
                              onSubmitted: (text) {
                                chatProvider.sendMessage(text);
                                chatProvider.clearController();
                              },
                            ),
                          ),
                        ),
                        if (chatProvider.sendingMessage)
                          GestureDetector(
                            onTap: () {
                              chatProvider.cancelSending();
                              chatProvider.clearController();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.stop, color: Colors.red),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: () {
                              chatProvider
                                  .sendMessage(chatProvider.controller.text);
                              chatProvider.clearController();
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
        ),
      );
}
