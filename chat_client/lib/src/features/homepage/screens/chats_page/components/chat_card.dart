import 'package:chat_client/src/constants/assets/assets.dart';
import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    this.image,
    this.lastMsg,
    this.isActive = false,
    required this.name,
    required this.onTap,
    required this.timeText,
  });

  final String name;
  final String? image;
  final String? lastMsg;
  final String timeText;
  final bool isActive;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPaddingSpace,
          vertical: defaultPaddingSpace * 0.75,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: const AssetImage(ImageAssets.profile),
                  foregroundImage: image == null ? null : NetworkImage(image!),
                ),
                if (isActive)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.color.primary,
                        border: Border.all(
                          width: 3,
                          color: context.color.background,
                        ),
                      ),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPaddingSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (lastMsg != null)
                      Opacity(
                        opacity: 0.64,
                        child: Text(
                          lastMsg!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.64,
              child: Text(timeText),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatCardShimmer extends StatelessWidget {
  const ChatCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    const baseColor = Color.fromARGB(255, 130, 126, 126);
    const shimmerColor = Colors.white70;
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: defaultPaddingSpace,
        vertical: defaultPaddingSpace * 0.75,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: baseColor,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPaddingSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ColoredBox(
                    color: baseColor,
                    child: SizedBox(height: 18, width: 120),
                  ),
                  SizedBox(height: 8),
                  Opacity(
                    opacity: 0.6,
                    child: ColoredBox(
                      color: baseColor,
                      child: SizedBox(height: 14, width: 200),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: 0.64,
            child: ColoredBox(
              color: baseColor,
              child: SizedBox(height: 14, width: 40),
            ),
          ),
        ],
      ),
    )
        .animate(
          autoPlay: true,
          onComplete: (controller) => controller.repeat(),
        )
        .shimmer(
          duration: 2.seconds,
          color: shimmerColor,
        );
  }
}
