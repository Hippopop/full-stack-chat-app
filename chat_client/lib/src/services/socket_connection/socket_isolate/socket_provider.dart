import 'dart:async';

import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:chat_client/src/services/socket_connection/models/homie_data/homie_data.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/socket_isolate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final socketProvider =
    FutureProvider.family<SocketIsolate<List<HomieData>>, String>(
  (ref, path) async {
    final authenticationState = ref.watch(authStateNotifierProvider);
    if (!authenticationState.isAuthenticated) {
      throw Exception("Unauthorized connection of a socket attempt!");
    }

    final socketIsolate = SocketIsolate<List<HomieData>>(
      connectionPath: path,
      tokenSet: authenticationState.token!,
    );

    final initialization = socketIsolate.initiate(
      riverpodRef: ref,
      dataPurser: (value) =>
          (value as List).map((e) => HomieData.fromJson(e)).toList(),
    );
    await initialization.timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw TimeoutException("Socket connection timed out!"),
    );

    ref.onDispose(() async {
      await socketIsolate.dispose();
    });
    return socketIsolate;
  },
);
