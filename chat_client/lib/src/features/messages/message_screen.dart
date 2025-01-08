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

MapEntry<String, Object> _stringToBool(String key, String value) {
  if (value == "true") {
    return MapEntry(key, true);
  } else if (value == "false") {
    return MapEntry(key, false);
  }
  return MapEntry(key, value);
}

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
        GoRouterState.of(context).uri.queryParameters.map(_stringToBool),
      );
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
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final userMessages =
                    ref.watch(userMessagesProvider(widget.uuid));
                return userMessages.when(
                  data: (data) => ListView.builder(
                    reverse: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPaddingSpace),
                      child: Message(
                        message: data[index],
                        homieProfileImage: queryData.photoUrl,
                      ),
                    ),
                  ),
                  error: (e, s) => Center(
                    child: Text(e.toString()),
                  ),
                  loading: () => Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: context.color.primary,
                    ),
                  ),
                );
              },
            ),
          ),
          ChatInputField(uuid: widget.uuid),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(onPressed: () => context.pop()),
          const SizedBox(width: defaultPaddingSpace / 2),
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
