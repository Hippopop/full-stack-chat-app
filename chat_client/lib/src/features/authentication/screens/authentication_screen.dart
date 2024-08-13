import 'package:chat_client/src/constants/assets/assets.dart';
import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/services/theme/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../global/widgets/primary_button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  static const path = "/Authentication";
  static const route = AuthenticationScreen.path;
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: horizontal20,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Center(
                  child: Image.asset(
                    context.isDarkTheme
                        ? ImageAssets.logoDark
                        : ImageAssets.logoLight,
                    height: 146,
                  ),
                ),
              ),
              const Spacer(),
              PrimaryButton(
                text: "Sign In",
                color: Theme.of(context).colorScheme.secondary,
                press: () => context.push(LoginScreen.route),
              ),
              const SizedBox(height: defaultPaddingSpace * 1.5),
              PrimaryButton(
                color: Theme.of(context).colorScheme.secondary,
                text: "Sign Up",
                press: () => context.push(RegistrationScreen.route),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
