import 'package:chat_client/src/constants/assets/assets.dart';
import 'package:chat_client/src/features/messages/components/message.dart';
import 'package:chat_client/src/features/messages/models/personal_chat_query.dart';

import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/services/socket_connection/data/personal_message_provider.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:chat_client/src/utilities/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/chat_message.dart';
import 'components/chat_input_field.dart';

class PersonalChatScreen extends StatefulWidget {
  static const path = "/PersonalChat/:uuid";
  static String route({
    required String uuid,
    PersonalChatQuery? queryParameters,
  }) {
    final path = "/PersonalChat/$uuid";
    final queryParams = queryParameters?.toJson()
      ?..removeWhere((key, value) => value == null);
    return Uri(
      path: path,
      queryParameters:
          queryParams?.map((key, value) => MapEntry(key, value.toString())),
    ).toString();
  }

  const PersonalChatScreen({
    super.key,
    required this.uuid,
  });

  final String uuid;
  @override
  State<PersonalChatScreen> createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  PersonalChatQuery get queryData => PersonalChatQuery.fromJson(
          GoRouterState.of(context).uri.queryParameters.map(
        (key, value) {
          if (value == "true") {
            return MapEntry(key, true);
          } else if (value == "false") {
            return MapEntry(key, false);
          }
          return MapEntry(key, value);
        },
      ));
  final List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Consumer(
        builder: (context, ref, child) {
          final userMessages = ref.watch(userMessagesProvider(widget.uuid));

          return userMessages.when(
            data: (data) => child!,
            error: (e, s) => Center(
              child: Text(e.toString()),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        child: Body(
          messageList: messages,
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
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
              const SizedBox(height: 2),
              if (!(queryData.isActive ?? false))
                Text(
                  () {
                    if ((queryData.isActive ?? false) ||
                        queryData.updatedAt == null) return "";
                    final text = DateTime.now()
                        .difference(queryData.updatedAt!)
                        .adaptiveDurationString;
                    return text == "Just now" ? text : "$text ago";
                  }(),
                  style: TextStyle(
                    fontSize: 10,
                    color: context.color.secondaryText,
                  ),
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
              reverse: true,
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
