import 'package:chat_client/src/constants/utils/date_utils.dart';
import 'package:chat_client/src/services/socket_connection/providers/homie_data_provider.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/design/paddings.dart';
import '../../../global/widgets/filled_outline_button.dart';
import 'components/chat_card.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final socket = ref.watch(homieDataProvider);

      return socket.when(
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
                    press: () {
                      // data.sendPort.send(
                      //   ("message", "Hi, I am a mobile user!"),
                      // );
                    },
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
                  final homie = data[index];

                  return ChatCard(
                    name: homie.homie.name,
                    isActive: homie.homie.isActive ?? false,
                    timeText: (homie.homie.isActive ?? false)
                        ? ""
                        : "${DateTime.now().difference(homie.homie.lastActivity!).inMinutes} min ago",
                    lastMsg: homie.message?.text ??
                        "Connected at ${homie.connection.acceptedAt == null ? "" : timeDate.format(homie.connection.acceptedAt!)}.",
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
