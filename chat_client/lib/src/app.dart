import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:chat_client/src/utilities/dialogues/overlay_loader.dart';
import 'package:chat_client/src/utilities/scaffold_utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/router/routes.dart';
import 'services/theme/controller/theme_controller.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(APIConfig.baseURL);
    final goRouter = ref.watch(goRouterProvider);
    final themeState = ref.watch(themeStateProvider);
    return LoadingOverlayWrapper.global(builder: (context) {
      return MaterialApp.router(
        routerConfig: goRouter,
        title: 'Full-Stack Chat',
        theme: themeState.currentTheme,
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: ScaffoldUtilities.instance.key,
      );
    });
  }
}
