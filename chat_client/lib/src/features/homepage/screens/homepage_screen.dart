import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_client/src/constants/assets/assets.dart';
import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:chat_client/src/features/search_user/screens/user_search_screen.dart';
import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';

import 'chats_page/chats_page.dart';

class HomepageScreen extends StatefulWidget {
  static const path = "/Home";
  static const route = HomepageScreen.path;
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Scaffold(
        appBar: buildAppBar(ref),
        body: const ChatsScreen(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(UserSearchScreen.route),
          backgroundColor: context.color.primary,
          child: const Icon(
            HugeIcons.strokeRoundedUserAdd02,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: buildBottomNavigationBar(ref),
      );
    });
  }

  BottomNavigationBar buildBottomNavigationBar(WidgetRef ref) {
    final state = ref.watch(authStateNotifierProvider);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(
          label: "Chats",
          icon: Builder(builder: (context) {
            return const Icon(
              HugeIcons.strokeRoundedBubbleChat,
            );
          }),
        ),
        BottomNavigationBarItem(
          label: "People",
          icon: Builder(builder: (context) {
            return const Icon(
              HugeIcons.strokeRoundedUserMultiple02,
            );
          }),
        ),
        BottomNavigationBarItem(
          label: "Calls",
          icon: Builder(builder: (context) {
            return const Icon(
              HugeIcons.strokeRoundedCall02,
            );
          }),
        ),
        BottomNavigationBarItem(
          icon: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.color.accent.withOpacity(0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                radius: 12,
                backgroundImage: ((state.currentUser?.photo == null)
                    ? const AssetImage(
                        ImageAssets.profile,
                      )
                    : NetworkImage(
                        APIConfig.baseURL + state.currentUser!.photo!,
                      )) as ImageProvider,
              ),
            ),
          ),
          label: "Profile",
        ),
      ],
    );
  }

  AppBar buildAppBar(WidgetRef ref) {
    return AppBar(
      backgroundColor: context.color.primary,
      automaticallyImplyLeading: false,
      title: const Text("Chats"),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await ref.watch(authStateNotifierProvider.notifier).logout();
          },
        ),
      ],
    );
  }
}
