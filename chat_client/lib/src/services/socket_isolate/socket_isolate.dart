import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'dart:developer';

import 'package:chat_client/src/services/socket_isolate/utils/event_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';

typedef TransactionMsg = ({String key, String msg});

class SocketIsolate {
  SocketIsolate._internal();
  factory SocketIsolate.factory() => _shared;
  static final SocketIsolate _shared = SocketIsolate._internal();

  final _initializationError = UnimplementedError(
    "Please call the initiate function before using the class!",
  );

  Future<void> initiate(
    ({String accessToken, String refreshToken}) tokens,
  ) async {
    try {
      _receivePort = ReceivePort();
      _receiveStream = StreamController.broadcast();
      _receivePort!.listen(_receiveStream!.add);

      _currentIsolate = await Isolate.spawn(
        __initIsolate,
        _receivePort!.sendPort,
        onExit: _receivePort!.sendPort,
        onError: _receivePort!.sendPort,
      );
      _sendPort = (await _receiveStream!.stream
          .firstWhere((port) => port is SendPort)) as SendPort;
      sendPort.send((SocketEventKeys.credentials, tokens));
    } catch (e, s) {
      log(
        error: e,
        stackTrace: s,
        name: "[$SocketIsolate]",
        "#InitializationError",
      );
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
  StreamController get receiveStreamController {
    if (_receiveStream == null) {
      throw _initializationError;
    }
    return _receiveStream!;
  }
}

__initIsolate(SendPort sendPort) async {
  final ReceivePort receivePort = ReceivePort();

  final wsUrl = (!kIsWeb && Platform.isAndroid)
      ? ('http://10.0.2.2:8080/')
      : ('http://localhost:8080/');

  final option =
      OptionBuilder().setTransports(['websocket']).setAuth({}).build();
  final Socket websocket = io(wsUrl, option);
  sendPort.send(receivePort.sendPort);

  websocket.onConnect(
    (event) {
      sendPort.send("Connection has been established!");
    },
  );
  websocket.on("message", (message) {
    sendPort.send(message.toString());
  });

  websocket.on(
    "connection_error",
    (data) {
      sendPort.send(data.toString());
    },
  );

  receivePort.listen(
    (message) {
      switch (message) {
        case (String key, String message):
          websocket.emit(key, message);
        case (String key, Object data):
          {
            if (key == SocketEventKeys.credentials) {}
          }
      }
    },
  );
}
