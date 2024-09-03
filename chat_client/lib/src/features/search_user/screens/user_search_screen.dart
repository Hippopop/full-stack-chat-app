import 'dart:developer';

import 'package:chat_client/src/constants/design/border_radius.dart';
import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/features/search_user/controller/user_search_controller.dart';
import 'package:chat_client/src/features/search_user/screens/components/searched_user_card.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:chat_client/src/utilities/extensions/size_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class UserSearchScreen extends StatefulWidget {
  static const path = "/UserSearch";
  static const route = UserSearchScreen.path;

  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        leadingWidth: 64,
        title: const Text("Search Users"),
        leading: Center(
          child: Padding(
            padding: horizontal12,
            child: SizedBox.square(
              dimension: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: br6,
                  border: Border.all(
                    color: context.color.accent.withOpacity(0.5),
                  ),
                ),
                child: IconButton(
                  onPressed: () => context.pop(),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          12.height,
          Padding(
            padding: all12,
            child: Consumer(builder: (context, ref, child) {
              return TextField(
                onChanged: (value) {
                  ref
                      .read(searchTextProvider.notifier)
                      .update((state) => value);
                },
                decoration: InputDecoration(
                  contentPadding: vertical12,
                  hintText: "Search by name or email or phone number..",
                  hintStyle:
                      context.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  border: const OutlineInputBorder(borderRadius: br12),
                  prefixIcon: Builder(
                    builder: (context) {
                      return HugeIcon(
                        size: 18.0,
                        color: context.theme.iconTheme.color!,
                        icon: HugeIcons.strokeRoundedSearch02,
                      );
                    },
                  ),
                ),
              );
            }),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final userList = ref.watch(userSearchControllerProvider);
                return userList.when(
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final user = data[index];
                      return SearchedUserCard(
                        name: user.name,
                        uuid: user.uuid,
                        image: user.photoUrl,
                        lastMsg: user.email,
                        connection: user.connection,
                        onTap: () {
                          // context.pop();
                          // context.push(
                          //   PersonalChatScreen.route(
                          //     uuid: user.uuid,
                          //     queryParameters: PersonalChatQuery(
                          //       name: user.name,
                          //       email: user.email,
                          //       phone: user.phone,
                          //       photo: user.photo,
                          //     ),
                          //   ),
                          // );
                        },
                      );
                    },
                  ),
                  error: (error, stackTrace) {
                    log(
                      "#UserSearchError",
                      error: error,
                      stackTrace: stackTrace,
                    );
                    return Center(
                      child: Text(
                        error.toString(),
                      ),
                    );
                  },
                  loading: () => ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return const SearchedUserCardShimmer();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
