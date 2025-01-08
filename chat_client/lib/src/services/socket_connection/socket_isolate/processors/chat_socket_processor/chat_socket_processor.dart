import 'dart:async';
import 'dart:isolate';
import 'dart:developer';

import 'package:uuid/uuid.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:chat_client/src/services/socket_connection/models/message/user_message.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/utils/event_keys.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/processors/processor.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/isolated_socket_state.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/socket_isolate_manager.dart';

class ChatSocketProcessor extends SocketIsolateProcessor<List<UserMessage>> {
  ChatSocketProcessor({required super.socketUri});

  @override
  bool get shouldConnect =>
      socketUri.pathSegments.contains(APIConfig.wsChat.replaceAll('/', ''));

  @override
  Future<void> processIncoming({
    required IsolateManagerState controls,
    required TokenSetType currentTokens,
  }) async {
    if (!shouldConnect) return;
    controls.unfilteredReceiveStream.stream.listen((event) {
      if (event case (:String key, :var value)) {
        switch (key) {
          case SocketActionKeys.data:
            {
              controls.dataStreamController.add(
                (value as List).map((e) => UserMessage.fromJson(e)).toList(),
              );
            }
          case SocketActionKeys.newMessage:
            {
              final message = UserMessage.fromJson(value);
              controls.dataStreamController.add([message]);
            }
        }
      }
    });
  }

  /// Private variable that will only be used inside the [Isolate]!
  final _acknowledgementList = <String>[];

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
    _acknowledgementList.clear();
    final seg = socketUri.pathSegments.last;
    final isUuid = Uuid.isValidUUID(fromString: seg);

    if (isUuid) {
      final receiver = seg;
      socket.on(SocketActionKeys.data, (data) {
        final list =
            (data as List).map((e) => UserMessage.fromJson(e)).toList();
        final needToUpdateList = list.where((element) =>
            element.state == MessageState.sent && element.sender == receiver);
        if (needToUpdateList.isNotEmpty) {
          socket.emit(
            UserMessageKeys.received,
            needToUpdateList.map((e) => e.key).toList(),
          );
        }
      });
    }

    receiveStream.stream.listen(
      (event) {
        if (event case (key: String key, value: var value)) {
          final isUuid = Uuid.isValidUUID(fromString: key);
          if (isUuid && value is String) {
            _acknowledgementList.add(key);
            socket.emitWithAck(
              UserMessageKeys.message,
              value,
              ack: (response) {
                log(response.toString());
                mySendPort.sendWithKey(key, response);
                _acknowledgementList.remove(key);
              },
            );
          } else {
            socket.emit(key, value);
          }
        }
      },
    );

    return socket;
  }
}
