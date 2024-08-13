import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../chats/components/body.dart';

class HomepageScreen extends StatefulWidget {
  static const path = "/Home";
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: context.color.primary,
        child: const Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, _) {
        return buildBottomNavigationBar(ref);
      }),
    );
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
        const BottomNavigationBarItem(
            icon: Icon(Icons.messenger), label: "Chats"),
        const BottomNavigationBarItem(
            icon: Icon(Icons.people), label: "People"),
        const BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            backgroundImage:
                NetworkImage(APIConfig.baseURL + state.currentUser!.photo!),
          ),
          label: "Profile",
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: context.color.primary,
      automaticallyImplyLeading: false,
      title: const Text("Chats"),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}
