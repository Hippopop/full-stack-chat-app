import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:chat_client/src/services/socket_connection/socket_isolate/isolated_socket_state.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/utils/event_keys.dart';
import 'package:socket_io_client/socket_io_client.dart';

typedef TokenSetType = ({String accessToken, String refreshToken});
typedef TokenResetCallback = Future<void> Function(dynamic tokenSet);

/// Creates and manages the data related to newly spawned `Isolate`!
class SocketIsolateManager<T> {
  final String socketPath;
  final TokenSetType tokenSet;

  SocketIsolateManager.uninitializedInstance({
    required this.tokenSet,
    required this.socketPath,
  });

  IsolateManagerState<T>? _currentState;
  IsolateManagerState<T> get state {
    if (_currentState == null) {
      throw UnimplementedError(
        "$SocketIsolateManager($socketPath) hasn't been initialized yet!",
      );
    }
    return _currentState!;
  }

  Future<void> dispose() async => await _currentState?.dispose();

  void send(({String key, dynamic value}) data) =>
      state.isolatesSendPort.send(data);

  Future<void> initiate({
    TokenResetCallback? resetToken,
    required T Function(dynamic value) dataPurser,
  }) async {
    try {
      final rPort = ReceivePort();
      final rStream = StreamController.broadcast();
      final dStream = StreamController<T>.broadcast();
      final sStream = StreamController<SocketConnectionStatus>.broadcast();

      rPort.listen(
        (message) {
          log(message.toString(), name: "FROM-ISOLATE");
          switch (message) {
            case (:String key, :var value):
              {
                //This means the stream data is in the [(:key, : value)] format!
                switch (key) {
                  case SocketActionKeys.freshToken:
                    resetToken?.call(value);
                  case SocketActionKeys.data:
                    dStream.add(dataPurser(value));
                  case IsolateEventKeys.socketStatus:
                    sStream.add(value);
                }
                rStream.add(message);
              }
            default:
              rStream.add(message);
          }
        },
      );

      final isolate = await Isolate.spawn(
        _$SocketHandlingIsolate,
        (sendPort: rPort.sendPort, connectionPath: socketPath),
      );

      final sendPort = await rStream.stream.first as SendPort;
      sendPort.send(tokenSet);

      // This ensures that some form of `ConnectionStatus` has been received from
      // the isolated socket!
      await sStream.stream.first;
      // Finally initialize the state!
      _currentState = IsolateManagerState(
        isolate: isolate,
        isolatesSendPort: sendPort,
        myReceivePort: rPort,
        dataStreamController: dStream,
        unfilteredReceiveStream: rStream,
        socketStatusStreamController: sStream,
      );
    } catch (e, s) {
      log(
        error: e,
        stackTrace: s,
        name: "$SocketIsolateManager->initiate",
        "🤯 Error while initiating the socket isolate!",
      );
      rethrow;
    }
  }
}

///
/// Entry point to the newly spawned `Isolate`!
///
Future<void> _$SocketHandlingIsolate(
  ({SendPort sendPort, String connectionPath}) config,
) async {
  final (:sendPort, :connectionPath) = config;
  final ReceivePort receivePort = ReceivePort();
  final StreamController receiverController = StreamController.broadcast();

  sendPort.send(receivePort.sendPort);
  receivePort.listen(receiverController.add);

  final (:accessToken, :refreshToken) =
      await receiverController.stream.firstWhere((port) {
    if (port case (accessToken: String _, refreshToken: String _)) {
      return true;
    }
    return false;
  });

  final connectionUri = Uri.parse(connectionPath);
  final option = OptionBuilder()
      .setTransports(['websocket'])
      .setReconnectionDelay(1000)
      .setReconnectionAttempts(10)
      .setReconnectionDelayMax(1000 * 6)
      .setAuth({
        'token': accessToken,
        'refreshToken': refreshToken,
      })
      .build();
  final Socket websocket = io(connectionUri.toString(), option);

  websocket.onConnect(
    (event) => sendPort.send((
      key: IsolateEventKeys.socketStatus,
      value: SocketConnectionStatus.connected,
    )),
  );

  websocket.onDisconnect(
    (data) => sendPort.send((
      key: IsolateEventKeys.socketStatus,
      value: SocketConnectionStatus.disconnected,
    )),
  );

  websocket.onConnectError(
    (data) => sendPort.send((
      key: IsolateEventKeys.socketStatus,
      value: SocketConnectionStatus.error,
    )),
  );

  websocket.onAny(
    (event, data) => sendPort.send((key: event, value: data)),
  );

  receiverController.stream.listen(
    (message) {
      log(message.toString(), name: "TO-ISOLATE");
      switch (message) {
        case (:String key, :String message):
          websocket.emit(key, message);
      }
    },
  );
}
