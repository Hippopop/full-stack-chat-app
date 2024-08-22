import 'package:chat_client/src/constants/assets/assets.dart';
import 'package:chat_client/src/features/messages/models/personal_chat_query.dart';
import 'package:chat_client/src/services/socket_isolate/socket_isolate.dart';

import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/chat_message.dart';
import 'components/body.dart';

class PersonalChatScreen extends StatefulWidget {
  static const path = "/PersonalChat/:uuid";
  static String route({required String uuid}) => "/PersonalChat/$uuid";

  const PersonalChatScreen({
    super.key,
    required this.uuid,
  });

  final String uuid;
  @override
  State<PersonalChatScreen> createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  PersonalChatQuery get queryData =>
      PersonalChatQuery.fromJson(GoRouterState.of(context).uri.queryParameters);
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
    print(queryData.toJson());
    print(GoRouterState.of(context).uri.queryParameters);
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
      title: Row(
        children: [
          const BackButton(),
          CircleAvatar(
            foregroundImage: queryData.photoUrl == null
                ? null
                : NetworkImage(queryData.photoUrl!),
            backgroundImage: const AssetImage(ImageAssets.profile),
          ),
          const SizedBox(width: defaultPaddingSpace * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                queryData.name ?? " ??? ",
                style: const TextStyle(fontSize: 16),
              ),
              if (queryData.activityStatus != null)
                Text(
                  queryData.activityStatus!,
                  style: const TextStyle(fontSize: 12),
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
