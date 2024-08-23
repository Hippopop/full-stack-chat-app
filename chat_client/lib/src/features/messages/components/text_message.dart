import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/data/models/chat_message.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    super.key,
    this.message,
  });

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // color: MediaQuery.of(context).platformBrightness == Brightness.dark
        //     ? Colors.white
        //     : Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPaddingSpace * 0.75,
          vertical: defaultPaddingSpace / 2,
        ),
        decoration: BoxDecoration(
          color: context.color.primary.withOpacity(message!.isSender ? 1 : 0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          message!.text,
          softWrap: true,
          textWidthBasis: TextWidthBasis.longestLine,
          style: TextStyle(
            color: message!.isSender
                ? Colors.white
                : Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ),
    );
  }
}
