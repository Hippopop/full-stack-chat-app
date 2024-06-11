import 'package:chat_client/src/services/theme/theme_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(),
      debugShowCheckedModeBanner: false,
      theme: ThemeConfiguration.initialTheme,
    );
  }
}
