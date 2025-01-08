import 'package:chat_client/src/constants/assets/assets.dart';
import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:chat_client/src/services/socket_connection/models/message/user_message.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'text_message.dart';

class Message extends ConsumerWidget {
  const Message({
    super.key,
    required this.message,
    required this.homieProfileImage,
  });

  final UserMessage message;
  final String? homieProfileImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authorizationProvider).currentUuid!;
    final isSender = message.sender == user;

    return Padding(
      padding: const EdgeInsets.only(top: defaultPaddingSpace),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender) ...[
            CircleAvatar(
              radius: 12,
              foregroundImage: (homieProfileImage == null)
                  ? null
                  : NetworkImage(homieProfileImage!),
              backgroundImage: const AssetImage(ImageAssets.profile),
            ),
            const SizedBox(width: defaultPaddingSpace / 2),
          ],
          TextMessage(
            text: message.text!,
            isSender: isSender,
          ),
          if (isSender) MessageStatusDot(status: message.state)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageState status;

  const MessageStatusDot({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageState status) {
      switch (status) {
        case MessageState.error:
          return context.color.errorState;
        case MessageState.delivered:
          return Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1);
        case MessageState.seen:
          return context.color.primary;
        default:
          return Colors.grey.withOpacity(0.7);
      }
    }

    return Container(
      margin: const EdgeInsets.only(left: defaultPaddingSpace / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageState.loading ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
