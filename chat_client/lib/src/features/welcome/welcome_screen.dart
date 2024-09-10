import 'package:chat_client/src/constants/design/paddings.dart';
import 'package:chat_client/src/services/theme/app_theme.dart';
import 'package:chat_client/src/utilities/extensions/size_utilities.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../authentication/screens/authentication_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const path = "/Welcome";
  static const route = WelcomeScreen.path;
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Image.asset("assets/images/welcome_image.png"),
            const Spacer(flex: 3),
            Text(
              "Welcome to our freedom \nmessaging app",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              "Freedom talk any person of your \nmother language.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.64),
              ),
            ),
            const Spacer(flex: 3),
            InkWell(
              onTap: () => context.go(AuthenticationScreen.route),
              customBorder: const StadiumBorder(),
              child: Padding(
                padding: horizontal10 + vertical8,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Skip",
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: context.color.primaryAccent.withOpacity(0.8),
                      ),
                    ),
                    6.width,
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.8),
                    )
                  ],
                ),
              ),
            ),
            20.height,
          ],
        ),
      ),
    );
  }
}
