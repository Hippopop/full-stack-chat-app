import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_client/src/services/socket_connection/models/homie_data/homie_data.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/providers/homie_socket_provider.dart';

final homieDataProvider =
    StreamNotifierProvider<CurrentHomieDataNotifier, List<HomieData>>(
  CurrentHomieDataNotifier.new,
);

class CurrentHomieDataNotifier extends StreamNotifier<List<HomieData>> {
  @override
  build() async* {
    final socket = await ref.watch(homieSocketProvider.future);
    yield* socket.state.dataStreamController.stream;
  }
}
