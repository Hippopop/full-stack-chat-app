import 'dart:developer';

import 'package:chat_client/src/constants/utils/date_utils.dart';
import 'package:chat_client/src/features/messages/message_screen.dart';
import 'package:chat_client/src/features/messages/models/personal_chat_query.dart';
import 'package:chat_client/src/services/socket_connection/data/homie_data_provider.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:chat_client/src/utilities/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/design/paddings.dart';
import '../../../global/widgets/filled_outline_button.dart';
import 'components/chat_card.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final homieListProvider = ref.watch(homieDataProvider);
      return homieListProvider.when(
        data: (data) => Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(
                defaultPaddingSpace,
                0,
                defaultPaddingSpace,
                defaultPaddingSpace,
              ),
              color: context.color.primary,
              child: Row(
                children: [
                  FillOutlineButton(
                    press: () {},
                    text: "Recent Message",
                  ),
                  const SizedBox(width: defaultPaddingSpace),
                  FillOutlineButton(
                    press: () {},
                    text: "Active",
                    isFilled: false,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final userData = data[index];

                  return ChatCard(
                    name: userData.homie.name,
                    isActive: userData.homie.isActive,
                    timeText: _getMessageText(
                      userData.homie.isActive,
                      userData.homie.lastActivity,
                    ),
                    lastMsg: userData.message?.text ??
                        "Connected at ${userData.connection.acceptedAt == null ? "" : timeDate.format(userData.connection.acceptedAt!)}.",
                    onTap: () {
                      context.push(
                        PersonalChatScreen.route(
                          uuid: userData.homie.uuid,
                          queryParameters: PersonalChatQuery(
                            name: userData.homie.name,
                            photo: userData.homie.photo,
                            isActive: userData.homie.isActive,
                            updatedAt: userData.homie.lastActivity,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        error: (error, stackTrace) {
          log("UserListError", error: error, stackTrace: stackTrace);
          return Center(
            child: Text(
              error.toString(),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  String _getMessageText(bool activeStatus, DateTime? lastActivity) {
    if (activeStatus || lastActivity == null) return "";
    final text = DateTime.now().difference(lastActivity).adaptiveDurationString;
    return text == "Just now" ? text : "$text ago";
  }
}
