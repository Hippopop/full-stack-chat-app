import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:chat_client/src/services/socket_connection/socket_isolate/isolated_socket_state.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/processors/chat_socket_processor/chat_socket_processor.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/processors/user_socket_processor/user_socket_processor.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/processors/web_socket_processor/web_socket_processor.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/utils/event_keys.dart';

/// Type of user token set.
typedef TokenSetType = ({String accessToken, String refreshToken});

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

  Future<void> initiate({void Function(dynamic value)? resetToken}) async {
    try {
      final rStream = StreamController.broadcast();
      final dStream = StreamController<T>.broadcast();
      final sStream = StreamController<SocketConnectionStatus>.broadcast();

      final rPort = ReceivePort();
      rPort.listen(rStream.add);
      if (resetToken != null) {
        rStream.stream.listen(
          (event) {
            if (event case (key: String key, value: var value)
                when key == SocketActionKeys.freshToken) {
              resetToken.call(value);
            }
          },
        );
      }

      // Actual initialization of the [Isolate].
      final isolate = await Isolate.spawn(
        _$SocketHandlingIsolate,
        (sendPort: rPort.sendPort, connectionPath: socketPath),
      );
      final sendPort = await rStream.stream.first as SendPort;

      // Finally initiate the state!
      final controls = IsolateManagerState<T>(
        isolate: isolate,
        isolatesSendPort: sendPort,
        myReceivePort: rPort,
        dataStreamController: dStream,
        unfilteredReceiveStream: rStream,
        socketStatusStreamController: sStream,
      );

      // Now set up the processor. But first make sure WebSocket part is settled!
      final uri = Uri.parse(socketPath);
      final wsProcessor = WebSocketProcessor(socketUri: uri);
      await wsProcessor.processIncoming(
        controls: controls,
        currentTokens: tokenSet,
      );

      final listOfProcessorFunctions = [
        UserSocketProcessor(socketUri: uri).processIncoming(
          controls: controls,
          currentTokens: tokenSet,
        ),
        ChatSocketProcessor(socketUri: uri).processIncoming(
          controls: controls,
          currentTokens: tokenSet,
        ),
      ];

      await Future.wait(listOfProcessorFunctions);

      // Finally assign the control state to this manager!
      _currentState = controls;
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

  final ReceivePort rPort = ReceivePort();
  final StreamController rStream = StreamController.broadcast();
  sendPort.send(rPort.sendPort);
  rPort.listen(rStream.add);

  // Await for the `authentication tokens` to arrive!
  final userTokens = await rStream.stream.firstWhere((port) {
    if (port case (accessToken: String _, refreshToken: String _)) {
      return true;
    }
    return false;
  });

  final connectionUri = Uri.parse(connectionPath);

  /// Process all the outgoing parts of your [IsolateSocketProcessors] here!
  /// And first one must be the WebSocketProcessor.
  final wsProcessor = WebSocketProcessor(socketUri: connectionUri);
  final ws = await wsProcessor.processOutgoing(
    mySendPort: sendPort,
    receiveStream: rStream,
    currentTokens: userTokens,
  );

  UserSocketProcessor(socketUri: connectionUri).processOutgoing(
    socket: ws,
    mySendPort: sendPort,
    receiveStream: rStream,
    currentTokens: userTokens,
  );

  ChatSocketProcessor(socketUri: connectionUri).processOutgoing(
    socket: ws,
    mySendPort: sendPort,
    receiveStream: rStream,
    currentTokens: userTokens,
  );
}
