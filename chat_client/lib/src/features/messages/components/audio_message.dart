import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/data/models/ChatMessage.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AudioMessage extends StatelessWidget {
  final ChatMessage? message;

  const AudioMessage({super.key, this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPaddingSpace * 0.75,
        vertical: defaultPaddingSpace / 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: context.color.primary.withOpacity(message!.isSender ? 1 : 0.1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: message!.isSender ? Colors.white : context.color.primary,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPaddingSpace / 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: message!.isSender
                        ? Colors.white
                        : context.color.primary.withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: message!.isSender
                            ? Colors.white
                            : context.color.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "0.37",
            style: TextStyle(
                fontSize: 12, color: message!.isSender ? Colors.white : null),
          ),
        ],
      ),
    );
  }
}
