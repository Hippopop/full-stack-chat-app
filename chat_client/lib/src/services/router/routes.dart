import 'package:chat_client/src/features/chat_page/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/homepage/screens/homepage.dart';
import '../initializer/views/error_screen.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: '#root');
    return GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      navigatorKey: rootNavigatorKey,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Homepage(),
        ),
        GoRoute(
          path: '/chat',
          builder: (context, state) => const ChatPage(),
        ),
      ],
      errorBuilder: (context, state) => GlobalErrorScreen(
        errorObject: state.error as Object,
      ),
    );
  },
);
