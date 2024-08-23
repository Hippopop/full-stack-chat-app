import 'package:chat_client/src/services/socket_isolate/socket_provider.dart';
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
      final socket = ref.watch(socketProvider);

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
                      data.sendPort.send(
                        ("message", "Hi, I am a mobile user!"),
                      );
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
                itemCount: 12,
                itemBuilder: (context, index) => ChatCard(
                  isActive: index.isEven,
                  name: "User name",
                  timeText: "3 min ago",
                  lastMsg: "Hey buddy! How you doing??",
                  onTap: () {},
                ),
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

/* 

HugeIcon(
  icon: HugeIcons.strokeRoundedSearch02,
  color: Colors.black,
  size: 24.0,
)

 */
