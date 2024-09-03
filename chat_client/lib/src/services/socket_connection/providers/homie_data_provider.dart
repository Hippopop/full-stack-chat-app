import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:chat_client/src/services/socket_connection/models/homie_data/homie_data.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/socket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homieDataProvider = StreamProvider<List<HomieData>>((ref) async* {
  final socket = await ref.watch(
    socketProvider(APIConfig.baseURL + APIConfig.wsUsers).future,
  );
  yield* socket.state.dataStreamController.stream;
});