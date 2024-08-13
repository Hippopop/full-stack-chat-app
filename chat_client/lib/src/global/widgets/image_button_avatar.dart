import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/design/paddings.dart';

class ImageAvatarWithButton extends StatelessWidget {
  const ImageAvatarWithButton({
    super.key,
    this.filePath,
    this.networkPath,
    required this.assetPath,
    required this.onAddClick,
  });

  final List<int>? filePath;
  final String assetPath;
  final String? networkPath;
  final VoidCallback onAddClick;

  @override
  Widget build(BuildContext context) {
    final ImageProvider foregroundImage = switch (filePath) {
      List<int>() => MemoryImage(Uint8List.fromList(filePath!)),
      _ => AssetImage(assetPath),
    } as ImageProvider;
    final ImageProvider backgroundImage = switch (networkPath) {
      String() => NetworkImage(
          networkPath!,
        ),
      _ => AssetImage(assetPath),
    } as ImageProvider;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.color.accent.withOpacity(0.5),
          ),
          child: Padding(
            padding: all3,
            child: CircleAvatar(
              minRadius: 32,
              maxRadius: 72,
              backgroundColor: Colors.white,
              foregroundImage: foregroundImage,
              backgroundImage: backgroundImage,
            ),
          ),
        ),
        Positioned(
          bottom: -18,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.color.primaryAccent,
            ),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: context.color.accent,
              ),
              visualDensity: VisualDensity.compact,
              onPressed: onAddClick,
            ),
          ),
        ),
      ],
    );
  }
}
