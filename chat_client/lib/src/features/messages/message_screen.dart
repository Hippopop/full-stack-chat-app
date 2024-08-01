import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart' as c;

import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/models/ChatMessage.dart';
import 'components/body.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late c.Socket ws;
  final List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();

    final wsUrl = (!kIsWeb && Platform.isAndroid)
        ? ('http://10.0.2.2:8080/')
        : ('http://localhost:8080/');

    ws = c.io(
        wsUrl,
        c.OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .build());
    ws.onConnect(
      (event) {
        messages.add(
          ChatMessage(
            text: "Connection initialized!",
            messageType: ChatMessageType.text,
            messageStatus: MessageStatus.viewed,
            isSender: false,
          ),
        );

        setState(() {});
      },
    );
    ws.on("message", (message) {
      messages.add(
        ChatMessage(
          text: message.toString(),
          messageType: ChatMessageType.text,
          messageStatus: MessageStatus.viewed,
          isSender: false,
        ),
      );
      setState(() {});
    });
    ws.emit('message', "Hearing back from mobile!");
  }

  @override
  void dispose() {
    ws.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(
        messageList: messages,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Row(
        children: [
          BackButton(),
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          SizedBox(width: defaultPaddingSpace * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kristin Watson",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () {},
        ),
        const SizedBox(width: defaultPaddingSpace / 2),
      ],
    );
  }
}
