import 'package:chat_client/src/features/authentication/authentication_screen.dart';
import 'package:chat_client/src/features/authentication/login.dart';
import 'package:chat_client/src/features/authentication/registration.dart';
import 'package:chat_client/src/features/chats/chats_screen.dart';
import 'package:chat_client/src/features/messages/message_screen.dart';
import 'package:chat_client/src/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../initializer/views/error_screen.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final isAuthenticated = false;
    final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: '#root');
    return GoRouter(
      initialLocation: ChatScreen.path,
      debugLogDiagnostics: true,
      navigatorKey: rootNavigatorKey,
      redirect: (context, state) async {
        final isHome = state.matchedLocation == ChatScreen.path;
        if (isHome && !isAuthenticated) {
          return WelcomeScreen.path;
        }
        return state.matchedLocation;
      },
      routes: [
        GoRoute(
          path: ChatScreen.path,
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: WelcomeScreen.path,
          builder: (context, state) => const WelcomeScreen(),
          routes: [
            GoRoute(
              path: AuthenticationScreen.path,
              builder: (context, state) => const AuthenticationScreen(),
              routes: [
                GoRoute(
                  path: LoginScreen.path,
                  builder: (context, state) => const LoginScreen(),
                ),
                GoRoute(
                  path: RegistrationScreen.path,
                  builder: (context, state) => const RegistrationScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => GlobalErrorScreen(
        errorObject: state.error as Object,
      ),
    );
  },
);
