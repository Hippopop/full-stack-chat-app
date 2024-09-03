import 'dart:async';
import 'dart:isolate';

enum SocketConnectionStatus {
  error,
  loading,
  connected,
  disconnected,
}

final class IsolatedSocketState<T> {
  final Isolate isolate;
  final SendPort isolatesSendPort;
  final ReceivePort myReceivePort;
  final StreamController unfilteredReceiveStream;
  final StreamController<T> dataStreamController;
  final StreamController<SocketConnectionStatus> socketStatusStreamController;

  IsolatedSocketState({
    required this.isolate,
    required this.isolatesSendPort,
    required this.myReceivePort,
    required this.unfilteredReceiveStream,
    required this.dataStreamController,
    required this.socketStatusStreamController,
  });

  Future<void> dispose() async {
    isolate.kill();
    myReceivePort.close();
    await dataStreamController.close();
    await unfilteredReceiveStream.close();
    await socketStatusStreamController.close();
  }
}
