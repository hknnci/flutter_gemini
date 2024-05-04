import 'package:flutter/material.dart';
import 'package:flutter_gemini/providers/chatbot_provider.dart';
import 'package:flutter_gemini/widgets/chat_message_tile.dart';
import 'package:flutter_gemini/widgets/input_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatbotProvider = Provider.of<ChatbotProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                      ).createShader(
                        const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                      ),
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
            NotificationListener<ScrollMetricsNotification>(
              onNotification: (notification) {
                if (notification.metrics.extentAfter > 12) {
                  chatbotProvider.animateScrollController();
                }
                return true;
              },
              child: Expanded(
                child: SingleChildScrollView(
                  controller: chatbotProvider.scrollController,
                  child: Consumer<ChatbotProvider>(
                    builder: (context, chat, _) => Stack(
                      children: [
                        ListView.builder(
                          itemCount: chat.messages.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ChatMessageTile(
                            message: chat.messages[index],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (chatbotProvider.sendingMessage)
              const Center(
                child: SpinKitThreeBounce(color: Colors.white, size: 20),
              ),
            const SizedBox(height: 2),
            const InputField(),
          ],
        ),
      ),
    );
  }
}
