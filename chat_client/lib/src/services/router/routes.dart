import 'package:chat_client/src/features/authentication/screens/authentication_screen.dart';
import 'package:chat_client/src/features/authentication/screens/login_screen.dart';
import 'package:chat_client/src/features/authentication/screens/registration_screen.dart';
import 'package:chat_client/src/features/homepage/screens/homepage_screen.dart';
import 'package:chat_client/src/features/messages/message_screen.dart';
import 'package:chat_client/src/features/search_user/screens/user_search_screen.dart';
import 'package:chat_client/src/features/welcome/welcome_screen.dart';
import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../initializer/views/error_screen.dart';

final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: '#root');
final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final authState = ref.watch(authStateNotifierProvider);
    return GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _navigatorKey,
      initialLocation: HomepageScreen.path,
      routes: [
        GoRoute(
          name: '$HomepageScreen',
          path: HomepageScreen.path,
          builder: (context, state) => const HomepageScreen(),
        ),
        GoRoute(
          name: '$WelcomeScreen',
          path: WelcomeScreen.path,
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          name: '$UserSearchScreen',
          path: UserSearchScreen.path,
          builder: (context, state) => const UserSearchScreen(),
        ),
        GoRoute(
          name: '$PersonalChatScreen',
          path: PersonalChatScreen.path,
          builder: (context, state) => PersonalChatScreen(
            uuid: state.pathParameters['uuid']!,
          ),
        ),
        GoRoute(
          name: '$AuthenticationScreen',
          path: AuthenticationScreen.path,
          builder: (context, state) => const AuthenticationScreen(),
          routes: [
            GoRoute(
              name: '$LoginScreen',
              path: LoginScreen.path,
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              name: '$RegistrationScreen',
              path: RegistrationScreen.path,
              builder: (context, state) => const RegistrationScreen(),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => GlobalErrorScreen(
        errorObject: state.error as Object,
      ),
      redirect: (context, state) async {
        final inAuthenticationPages = [
          LoginScreen.route,
          WelcomeScreen.route,
          AuthenticationScreen.route,
          RegistrationScreen.route,
        ].contains(state.matchedLocation);
        if (inAuthenticationPages && authState.isAuthenticated) {
          return HomepageScreen.path;
        }
        if (!inAuthenticationPages && !authState.isAuthenticated) {
          return WelcomeScreen.path;
        }
      },
    );
  },
);
