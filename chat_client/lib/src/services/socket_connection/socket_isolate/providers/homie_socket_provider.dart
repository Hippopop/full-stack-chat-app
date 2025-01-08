import 'dart:async';
import 'dart:developer';

import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:chat_client/src/domain/repository.dart';
import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:chat_client/src/services/socket_connection/models/homie_data/homie_data.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/socket_isolate_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homieSocketProvider =
    FutureProvider.autoDispose<SocketIsolateManager<List<HomieData>>>(
  (ref) async {
    final authenticationState = ref.watch(userStateNotifierProvider);
    if (!authenticationState.isAuthenticated) {
      throw Exception("Unauthorized connection of a socket attempt!");
    }

    final socketIsolate =
        SocketIsolateManager<List<HomieData>>.uninitializedInstance(
      tokenSet: authenticationState.token!,
      socketPath: APIConfig.baseURL + APIConfig.wsUsers,
    );

    final initialization = socketIsolate.initiate(
      resetToken: (tokenSet) async {
        final newToken = UserToken.fromJson(tokenSet);
        ref.read(userStateNotifierProvider.notifier).saveUserToken(newToken);
      },
    );

    await initialization.timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw TimeoutException("Socket connection timed out!"),
    );

    ref.onDispose(() async {
      await socketIsolate.dispose();
      log("Disposing HomieDataProvider!");
    });
    return socketIsolate;
  },
);
