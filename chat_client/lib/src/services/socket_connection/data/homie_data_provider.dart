import 'dart:async';
import 'package:chat_client/src/services/socket_connection/socket_isolate/socket_isolate_manager.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_client/src/services/socket_connection/models/homie_data/homie_data.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/providers/homie_socket_provider.dart';

final homieDataProvider = AutoDisposeStreamNotifierProvider<
    CurrentHomieDataNotifier, List<HomieData>>(
  CurrentHomieDataNotifier.new,
);

class CurrentHomieDataNotifier
    extends AutoDisposeStreamNotifier<List<HomieData>> {
  late SocketIsolateManager<List<HomieData>> _socket;
  @override
  build() async* {
    _socket = await ref.watch(homieSocketProvider.future);

    final timer = Timer.periodic(4.seconds, (timer) {
      _socket.send(key: "REFRESH");
    });
    ref.onDispose(timer.cancel);

    yield* _socket.state.dataStreamController.stream;
  }
}
