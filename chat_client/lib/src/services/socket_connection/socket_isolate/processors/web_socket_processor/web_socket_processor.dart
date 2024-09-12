import 'dart:async';
import 'dart:isolate';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/utils/event_keys.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/isolated_socket_state.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/processors/processor.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/socket_isolate_manager.dart';

class WebSocketProcessor extends SocketIsolateProcessor {
  WebSocketProcessor({required super.socketUri});

  @override
  bool get shouldConnect => true; // We always need the socket to initiate.

  @override
  Future<void> processIncoming({
    required TokenSetType currentTokens,
    required IsolateManagerState controls,
  }) async {
    // Attach the websocket status controlling logic for the app!
    controls.unfilteredReceiveStream.stream.listen((event) {
      if (event case (:String key, :var value)
          when [IsolateEventKeys.socketStatus, IsolateEventKeys.error]
              .contains(key)) {
        if (key == IsolateEventKeys.socketStatus) {
          controls.socketStatusStreamController.add(value);
        } else {
          controls.socketStatusStreamController.addError(value);
        }
      }
    });
    // First send the `authentication` tokens to initiate socket with auth!
    // This ensures that some form of `ConnectionStatus` has been received from
    // the isolated socket!
    controls.isolatesSendPort.send(currentTokens);
    await controls.socketStatusStreamController.stream.first;
  }

  @override
  Future<Socket> processOutgoing({
    Socket? socket,
    required SendPort mySendPort,
    required TokenSetType currentTokens,
    required StreamController receiveStream,
  }) async {
    /// Web socket config!
    final option = OptionBuilder()
        .setTransports(['websocket'])
        .setReconnectionDelay(1000)
        .setReconnectionAttempts(10)
        .setReconnectionDelayMax(1000 * 6)
        .setAuth({
          'token': currentTokens.accessToken,
          'refreshToken': currentTokens.refreshToken,
        })
        .build();
    final Socket websocket = io(socketUri.toString(), option);

    /// Send all data/error through [SendPort]!
    websocket.onAny((event, data) => mySendPort.sendWithKey(event, data));
    websocket.onerror((e) => mySendPort.sendWithKey(IsolateEventKeys.error, e));

    /// Send all connection state with the [IsolateEventKeys] as key!
    websocket.onConnect(
      (event) => mySendPort.sendWithKey(
        IsolateEventKeys.socketStatus,
        SocketConnectionStatus.connected,
      ),
    );

    websocket.onDisconnect(
      (data) => mySendPort.sendWithKey(
        IsolateEventKeys.socketStatus,
        SocketConnectionStatus.disconnected,
      ),
    );

    websocket.onConnectError(
      (err) {
        mySendPort.sendWithKey(
          IsolateEventKeys.socketStatus,
          SocketConnectionStatus.error,
        );
        mySendPort.sendWithKey(IsolateEventKeys.socketConnectionError, err);
      },
    );

    return websocket;
  }
}
