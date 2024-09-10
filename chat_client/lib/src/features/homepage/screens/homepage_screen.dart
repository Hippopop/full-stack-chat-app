import 'package:chat_client/src/constants/design/paddings.dart';
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
    final state = ref.watch(userStateNotifierProvider);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      unselectedFontSize: 14,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        const BottomNavigationBarItem(
          label: "Chats",
          icon: Padding(
            padding: all4,
            child: Icon(
              HugeIcons.strokeRoundedBubbleChat,
            ),
          ),
        ),
        const BottomNavigationBarItem(
          label: "People",
          icon: Padding(
            padding: all4,
            child: Icon(
              HugeIcons.strokeRoundedUserMultiple02,
            ),
          ),
        ),
        const BottomNavigationBarItem(
          label: "Calls",
          icon: Padding(
            padding: all4,
            child: Icon(
              HugeIcons.strokeRoundedCall02,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Padding(
            padding: const EdgeInsets.all(2.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.color.accent.withOpacity(0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  radius: 10,
                  backgroundImage: _getProfileImage(state.currentUser?.photo),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ImageProvider _getProfileImage(String? path) {
    if (path == null) {
      const AssetImage(ImageAssets.profile);
    }
    return NetworkImage(APIConfig.baseURL + path!);
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
            await ref.watch(userStateNotifierProvider.notifier).logout();
          },
        ),
      ],
    );
  }
}
