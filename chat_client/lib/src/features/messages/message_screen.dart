import 'package:chat_client/src/services/socket_isolate/socket_isolate.dart';

import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:flutter/material.dart';

import '../../data/models/ChatMessage.dart';
import 'components/body.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late final SocketIsolate isolate;
  final List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    isolate = SocketIsolate.factory();
    isolate.initiate().then((_) {
      isolate.receiveStreamController.stream.listen(_isolateListener);
      isolate.sendPort.send(("message", "Sending this message from mobile!"));
    });
  }

  _isolateListener(msg) {
    setState(() {
      messages.add(ChatMessage(
        text: msg.toString(),
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: false,
      ));
    });
  }

  @override
  void dispose() {
    isolate.dispose();
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
