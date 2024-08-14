import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/data/models/chat_message.dart';
import 'package:flutter/material.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.messageList});

  final List<ChatMessage> messageList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: defaultPaddingSpace),
            child: ListView.builder(
              itemCount: messageList.length,
              itemBuilder: (context, index) =>
                  Message(message: messageList[index]),
            ),
          ),
        ),
        const ChatInputField(),
      ],
    );
  }
}
