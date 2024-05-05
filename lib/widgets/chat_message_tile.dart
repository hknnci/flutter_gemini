import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ChatMessageTile extends StatelessWidget {
  final String message;

  const ChatMessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.startsWith("You: ");
    final displayMessage = isUser ? message.substring(5) : message.substring(8);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      visualDensity: VisualDensity.compact,
      title: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: isUser ? Colors.blue : Colors.grey[200],
              ),
              padding: const EdgeInsets.all(12.0),
              child: isUser
                  ? Text(
                      displayMessage,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    )
                  : AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          displayMessage,
                          textStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          speed: const Duration(milliseconds: 3),
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
