import 'dart:async';
import 'dart:isolate';

import 'package:socket_io_client/socket_io_client.dart';

import '../isolated_socket_state.dart';
import '../socket_isolate_manager.dart';

/// To send data as a value/key pattern through [SendPort]!
extension SendKeyValueData on SendPort {
  void sendWithKey(String key, dynamic value) => send((key: key, value: value));
}

/// Abstract shape/structure for the `Processor`s. And all these processors
/// do is tell both the UI [Isolate] and the newly Spawned Isolate to how to process
/// the instructions they receive. Also checks if they are related to to the isolate based on the
/// socket path. And decide if they should attach their methods on the processing streams.
/// It's more like an abstraction layer to the functionalities you can make your isolate and app process while
/// making everything tad-bit organized.
abstract class SocketIsolateProcessor<T> {
  final Uri socketUri;

  SocketIsolateProcessor({required this.socketUri});

  /// Should this processor, process the current [Isolate] data.
  bool get shouldConnect;

  /// Process all the data coming from the [Isolate].
  Future<void> processIncoming({
    required IsolateManagerState<T> controls,
    required TokenSetType currentTokens,
  });

  /// Process the events inside `Isolate`s.
  Future<Socket?> processOutgoing({
    Socket? socket,
    required SendPort mySendPort,
    required TokenSetType currentTokens,
    required StreamController receiveStream,
  });
}
