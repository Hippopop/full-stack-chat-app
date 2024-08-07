import 'package:chat_client/src/features/authentication/authentication_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const path = "Login";
  static const route = "${AuthenticationScreen.route}/$path";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Placeholder(
        child: Text("Login"),
      ),
    );
  }
}
