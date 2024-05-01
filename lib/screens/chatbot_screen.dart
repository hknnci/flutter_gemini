import 'package:flutter/material.dart';
import 'package:flutter_gemini/models/chatbot_service.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Chatbot App'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<ChatbotService>(
              builder: (context, chat, _) => ListView.builder(
                itemCount: chat.messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(chat.messages[index]),
                  );
                },
              ),
            ),
          ),
          _buildInputField(context),
        ],
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Enter your message'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                Provider.of<ChatbotService>(context, listen: false)
                    .sendMessage(controller.text);
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
