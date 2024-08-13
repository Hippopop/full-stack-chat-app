import 'package:chat_client/src/features/authentication/screens/authentication_screen.dart';
import 'package:chat_client/src/features/authentication/screens/login_screen.dart';
import 'package:chat_client/src/features/authentication/screens/registration_screen.dart';
import 'package:chat_client/src/features/homepage/screens/homepage_screen.dart';
import 'package:chat_client/src/features/welcome/welcome_screen.dart';
import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../initializer/views/error_screen.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final authState = ref.watch(authStateNotifierProvider);
    final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: '#root');
    return GoRouter(
      initialLocation: HomepageScreen.path,
      debugLogDiagnostics: true,
      navigatorKey: rootNavigatorKey,
      redirect: (context, state) async {
        final isHome = state.matchedLocation == HomepageScreen.path;
        if (isHome && !authState.isAuthenticated) {
          return WelcomeScreen.path;
        }
        return state.matchedLocation;
      },
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
    );
  },
);
