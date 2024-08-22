import 'package:chat_client/src/services/socket_isolate/socket_isolate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final socketProvider = FutureProvider<SocketIsolate>((ref) async {
  final socket = SocketIsolate.factory();
  await socket.initiate();
  ref.onDispose(() {
    socket.dispose();
  });
  return socket;
});
