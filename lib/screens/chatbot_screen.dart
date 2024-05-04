import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gemini/models/chatbot_service.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatbotProvider = Provider.of<ChatbotService>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: 'Gemini ',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: <Color>[Colors.purple, Colors.blue],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
              const TextSpan(
                text: 'Chatbot App',
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<ChatbotService>(
              builder: (context, chat, _) => Stack(
                children: [
                  ListView.builder(
                    controller: chat.scrollController,
                    itemCount: chat.messages.length,
                    itemBuilder: (context, index) {
                      if (chat.messages[index].startsWith("You: ")) {
                        return _buildMessageTile(
                          message: chat.messages[index].substring(5),
                          isUser: true,
                        );
                      } else {
                        return _buildMessageTile(
                          message: chat.messages[index].substring(8),
                          isUser: false,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          if (chatbotProvider.sendingMessage)
            const Center(
              child: SpinKitThreeBounce(color: Colors.white, size: 20),
            ),
          _buildInputField(context),
        ],
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.white70),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
    );
  }

  Widget _buildMessageTile({String message = '', bool isUser = true}) {
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
                borderRadius: BorderRadius.circular(8.0),
                color: isUser ? Colors.blue : Colors.grey[200],
              ),
              padding: const EdgeInsets.all(12.0),
              child: isUser
                  ? Text(
                      message,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    )
                  : AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          message,
                          textStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context, String message) {
    if (message.isNotEmpty) {
      Provider.of<ChatbotService>(context, listen: false).sendMessage(message);
    }
  }
}
