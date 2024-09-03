import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:chat_client/src/repositories/server/auth_repository/models/token/user_token.dart';
import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/isolated_socket_state.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/utils/event_keys.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketIsolate<T> {
  final String connectionPath;
  final ({String accessToken, String refreshToken}) tokenSet;

  SocketIsolate({
    required this.tokenSet,
    required this.connectionPath,
  });

  IsolatedSocketState<T>? _currentState;
  IsolatedSocketState<T> get state {
    if (_currentState == null) {
      throw UnimplementedError(
        "$SocketIsolate hasn't been initialized yet!",
      );
    }
    return _currentState!;
  }

  Future<void> dispose() async => await _currentState?.dispose();

  Future<void> initiate({
    required T Function(dynamic value) dataPurser,
    required FutureProviderRef<SocketIsolate> riverpodRef,
  }) async {
    try {
      final receivePort = ReceivePort();
      final dataStream = StreamController<T>.broadcast();
      final receiveStream = StreamController.broadcast();
      final socketStatusStream =
          StreamController<SocketConnectionStatus>.broadcast();

      receivePort.listen(
        (message) {
          print(message.toString());
          if (message case (:String key, :var value)) {
            print("Received from Isolate() : $key, $value");
            if (key == SocketActionKeys.homieData) {
              dataStream.add(dataPurser(value));
            }
            if (key == IsolateEventKeys.socketStatus) {
              socketStatusStream.add(value);
            }
            if (key == SocketActionKeys.freshToken) {
              riverpodRef
                  .read(authStateNotifierProvider.notifier)
                  .saveUserToken(UserToken.fromJson(value));
            }
          }
          receiveStream.add(message);
        },
      );

      final isolate = await Isolate.spawn(
        __initIsolate,
        (sendPort: receivePort.sendPort, connectionPath: connectionPath),
        onExit: receivePort.sendPort,
        onError: receivePort.sendPort,
      );

      final sendPort =
          await receiveStream.stream.firstWhere((i) => i is SendPort);

      sendPort.send(tokenSet);
      await socketStatusStream.stream.first;
      sendPort.send(
        (key: "Connection", value: "User connected with the client!"),
      );

      _currentState = IsolatedSocketState(
        isolate: isolate,
        isolatesSendPort: sendPort,
        myReceivePort: receivePort,
        dataStreamController: dataStream,
        unfilteredReceiveStream: receiveStream,
        socketStatusStreamController: socketStatusStream,
      );
    } catch (e, s) {
      log(
        error: e,
        stackTrace: s,
        name: "[$SocketIsolate]",
        "#InitializationError",
      );
      rethrow;
    }
  }
}

///
///
///
///
/// This is the area where the isolate works!
///
///
///
///
///
__initIsolate(({SendPort sendPort, String connectionPath}) config) async {
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

  final option = OptionBuilder()
      .setTransports(['websocket'])
      .setReconnectionDelay(1000)
      .setReconnectionAttempts(100)
      .setReconnectionDelayMax(1000 * 60)
      .setAuth({
        'token': accessToken,
        'refreshToken': refreshToken,
      })
      .build();
  final Socket websocket = io(connectionPath, option);

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
      switch (message) {
        case (:String key, :String message):
          websocket.emit(key, message);
      }
    },
  );
}
