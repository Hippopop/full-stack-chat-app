import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:chat_client/src/repositories/server/auth_repository/models/token/user_token.dart';
import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:chat_client/src/services/socket_connection/models/homie_data/homie_data.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/utils/event_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum SocketConnectionStatus {
  loading,
  connected,
  disconnected,
  error,
}

class SocketIsolate {
  SocketIsolate._internal();
  factory SocketIsolate.factory() => _shared;
  static final SocketIsolate _shared = SocketIsolate._internal();

  final _initializationError = UnimplementedError(
    "Please call the initiate function before using the class!",
  );

  Future<void> initiate(
    ({String accessToken, String refreshToken}) tokens,
    FutureProviderRef<SocketIsolate> riverpodRef,
  ) async {
    try {
      _receivePort = ReceivePort();
      _receiveStream = StreamController.broadcast();
      _socketStatusStream = StreamController.broadcast();
      _dataStream = StreamController.broadcast();
      _receivePort!.listen(
        (message) {
          print(message.toString());
          if (message case (:String key, :var value)) {
            print("Received from Isolate() : $key, $value");
            if (key == SocketActionKeys.homieData) {
              _dataStream?.add(
                (value as List)
                    .map((rawData) => HomieData.fromJson(rawData))
                    .toList(),
              );
            }

            if (key == IsolateEventKeys.socketStatus) {
              _socketStatusStream?.add(value);
            }

            if (key == SocketActionKeys.freshToken) {
              final newToken = UserToken.fromJson(value);
              riverpodRef
                  .read(authStateNotifierProvider.notifier)
                  .saveUserToken(newToken);
            }
          }
          _receiveStream!.add(message);
        },
      );

      _currentIsolate = await Isolate.spawn(
        __initIsolate,
        _receivePort!.sendPort,
        onExit: _receivePort!.sendPort,
        onError: _receivePort!.sendPort,
      );
      _sendPort = (await _receiveStream!.stream
          .firstWhere((port) => port is SendPort)) as SendPort;
      sendPort.send(tokens);
      await _socketStatusStream!.stream.first;
      _sendPort?.send((key: "Connection", "User connected with the client!"));
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

  bool get isInitialized =>
      _sendPort != null && _receivePort != null && _currentIsolate != null;

  void dispose() {
    _receiveStream?.close();
    _receivePort?.close();
    _currentIsolate?.kill();
  }

  SendPort? _sendPort;
  SendPort get sendPort {
    if (_sendPort == null) {
      throw _initializationError;
    }
    return _sendPort!;
  }

  Isolate? _currentIsolate;
  Isolate get isolate {
    if (_currentIsolate == null) {
      throw _initializationError;
    }
    return _currentIsolate!;
  }

  ReceivePort? _receivePort;
  StreamController? _receiveStream;
  StreamController<List<HomieData>>? _dataStream;
  StreamController<SocketConnectionStatus>? _socketStatusStream;
  StreamController get receiveStreamController {
    if (_receiveStream == null) {
      throw _initializationError;
    }
    return _receiveStream!;
  }

  StreamController<List<HomieData>> get homieDataController {
    if (_dataStream == null) {
      throw _initializationError;
    }
    return _dataStream!;
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
__initIsolate(SendPort sendPort) async {
  final ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  final StreamController receiverController = StreamController.broadcast();
  receivePort.listen(
    (message) {
      print("Inside ISOLATE: ${message.toString()}");
      receiverController.add(message);
    },
  );

  final (:accessToken, :refreshToken) =
      await receiverController.stream.firstWhere((port) {
    if (port case (accessToken: String _, refreshToken: String _)) {
      return true;
    } else {
      return false;
    }
  });

  final wsUrl = (!kIsWeb && Platform.isAndroid)
      ? ('http://10.0.2.2:8080/users')
      : ('http://localhost:8080/users');

  final option = OptionBuilder().setTransports(['websocket']).setAuth({
    'token': accessToken,
    'refreshToken': refreshToken,
  }).build();

  final Socket websocket = io(wsUrl, option);

  websocket.onConnect(
    (event) {
      sendPort.send((
        key: IsolateEventKeys.socketStatus,
        value: SocketConnectionStatus.connected,
      ));
      sendPort.send("Connection has been established!");
    },
  );

  websocket.onAny(
    (event, data) => sendPort.send((key: event, value: data)),
  );

  websocket.on("message", (message) {
    sendPort.send(message.toString());
  });

  websocket.on(
    'disconnect',
    (data) => sendPort.send((
      key: IsolateEventKeys.socketStatus,
      value: SocketConnectionStatus.disconnected
    )),
  );

  websocket.on(
    "connection_error",
    (data) {
      sendPort.send(("connection_error", data.toString()));
      sendPort.send((
        key: IsolateEventKeys.socketStatus,
        value: SocketConnectionStatus.error,
      ));
    },
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
