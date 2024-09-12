import 'dart:async';

import 'dart:isolate';

import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:chat_client/src/services/socket_connection/models/homie_data/homie_data.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/utils/event_keys.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/isolated_socket_state.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/processors/processor.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/socket_isolate_manager.dart';
import 'package:socket_io_client/socket_io_client.dart';

class UserSocketProcessor extends SocketIsolateProcessor<List<HomieData>> {
  UserSocketProcessor({required super.socketUri});

  @override
  bool get shouldConnect =>
      socketUri.pathSegments.contains(APIConfig.wsUsers.replaceAll('/', ''));

  @override
  Future<void> processIncoming({
    required IsolateManagerState controls,
    required TokenSetType currentTokens,
  }) async {
    if (!shouldConnect) return;
    controls.unfilteredReceiveStream.stream.listen(
      (event) {
        if (event case (:String key, :var value)
            when key == SocketActionKeys.data) {
          controls.dataStreamController.add(
            (value as List).map((e) => HomieData.fromJson(e)).toList(),
          );
        }
      },
    );
  }

  @override
  Future<Socket?> processOutgoing({
    Socket? socket,
    required SendPort mySendPort,
    required TokenSetType currentTokens,
    required StreamController receiveStream,
  }) async {
    if (!shouldConnect || (socket == null)) {
      return socket;
    }

    /// TODO: ADD ALL THE SOCKET END ACTIONS FOR THIS PATH!
    return socket;
  }
}
