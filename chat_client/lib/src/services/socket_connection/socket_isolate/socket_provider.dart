import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/socket_isolate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final socketProvider = FutureProvider<SocketIsolate>((ref) async {
  final authenticationState = ref.watch(authStateNotifierProvider);
  if (!authenticationState.isAuthenticated) {
    throw Exception("Unauthorized connection of a socket attempt!");
  }

  final socket = SocketIsolate.factory();
  await socket.initiate(authenticationState.token!, ref);
  ref.onDispose(() {
    socket.dispose();
  });
  return socket;
});
