import 'package:chat_client/src/features/authentication/screens/authentication_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  static const path = "Registration";
  static const route = "${AuthenticationScreen.route}/$path";
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Placeholder(
        child: Text("Registration"),
      ),
    );
  }
}
