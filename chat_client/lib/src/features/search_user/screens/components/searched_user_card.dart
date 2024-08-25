import 'package:chat_client/src/constants/assets/assets.dart';
import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/features/search_user/controller/user_search_controller.dart';
import 'package:chat_client/src/repositories/server/user_repository/models/connection_data.dart';
import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class SearchedUserCard extends StatelessWidget {
  const SearchedUserCard({
    super.key,
    this.image,
    this.lastMsg,
    this.connection,
    this.isActive = false,
    required this.name,
    required this.uuid,
    required this.onTap,
  });

  final String name;
  final String uuid;
  final String? image;
  final String? lastMsg;
  final ConnectionData? connection;
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
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.color.primary.withOpacity(0.1),
              ),
              child: Consumer(builder: (context, ref, child) {
                final myUUID =
                    ref.watch(authStateNotifierProvider).currentUser!.uuid;
                final isSender = connection?.fromUser == myUUID;
                // final isReceiver = connection?.toUser == myUUID;
                final isRequested =
                    connection?.connectionStatus == ConnectionStatus.requested;
                final isAccepted =
                    connection?.connectionStatus == ConnectionStatus.accepted;

                final paused = (isSender && isRequested) || isAccepted;
                return IconButton(
                  onPressed: paused
                      ? null
                      : () {
                          final notifier =
                              ref.read(userSearchControllerProvider.notifier);
                          if (connection == null) {
                            notifier.requestConnection(userUUID: uuid);
                          } else {
                            switch (connection!.connectionStatus) {
                              case ConnectionStatus.requested:
                                {
                                  notifier.updateConnectionRequest(
                                    connectionKey: connection!.key,
                                    status: ConnectionStatus.accepted,
                                  );
                                }
                              case ConnectionStatus.accepted:
                              // TODO: Handle this case.
                              case ConnectionStatus.rejected:
                              // TODO: Handle this case.
                              case ConnectionStatus.blocked:
                              // TODO: Handle this case.
                            }
                          }
                        },
                  icon: HugeIcon(
                    icon: (connection == null)
                        ? HugeIcons.strokeRoundedUserAdd02
                        : switch (connection!.connectionStatus) {
                            ConnectionStatus.blocked =>
                              HugeIcons.strokeRoundedUserLock02,
                            ConnectionStatus.rejected =>
                              HugeIcons.strokeRoundedUserRemove02,
                            ConnectionStatus.requested => isSender
                                ? HugeIcons.strokeRoundedSent
                                : HugeIcons.strokeRoundedUserCheck01,
                            ConnectionStatus.accepted =>
                              HugeIcons.strokeRoundedUserMultiple02,
                          },
                    color: paused ? context.color.theme : context.color.accent,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchedUserCardShimmer extends StatelessWidget {
  const SearchedUserCardShimmer({super.key});

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
