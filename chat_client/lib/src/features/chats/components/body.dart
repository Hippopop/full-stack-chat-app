import 'package:chat_client/src/features/messages/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_client/src/data/models/chat.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';

import '../../../constants/design/paddings.dart';
import '../../global/widgets/filled_outline_button.dart';
import 'chat_card.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MessagesScreen(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
