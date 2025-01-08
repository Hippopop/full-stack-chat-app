import 'dart:developer';

import 'package:chat_client/src/services/socket_connection/models/message/user_message.dart';
import 'package:chat_client/src/services/socket_connection/socket_isolate/socket_isolate_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/v4.dart';

import '../socket_isolate/providers/message_socket_provider.dart';
import '../socket_isolate/utils/event_keys.dart';

final userMessagesProvider = AutoDisposeStreamNotifierProviderFamily<
    UserMessageStreamNotifier, List<UserMessage>, String>(
  UserMessageStreamNotifier.new,
);

class UserMessageStreamNotifier
    extends AutoDisposeFamilyStreamNotifier<List<UserMessage>, String> {
  late SocketIsolateManager<List<UserMessage>> _socket;

  @override
  build(arg) async* {
    _socket = await ref.watch(chatSocketProvider(arg).future);
    _socket.state.unfilteredReceiveStream.stream.listen(_newMessageListener);

    ref.onDispose(() => log("Disposing connection with $arg"));

    yield* _socket.state.dataStreamController.stream;
  }

  void _newMessageListener(event) {
    if (event case (key: String key, value: var value)) {
      switch (key) {
        case SocketActionKeys.newMessage:
          {
            final message = UserMessage.fromJson(value);
            _socket.state.dataStreamController.add(
              [message, ...state.requireValue],
            );
          }
      }
    }
  }

  Future<void> sendTextMessage(String text) async {
    final uuid = const UuidV4().generate();
    _socket.send(key: uuid, value: text);
    _socket.state.unfilteredReceiveStream.stream.firstWhere(
      (element) {
        if (element case (key: String key, value: var _) when key == uuid) {
          return true;
        }
        return false;
      },
    ).then(
      (value) {
        if (value case (key: String key, value: var value) when key == uuid) {
          final message = UserMessage.fromJson(value);
          _socket.state.dataStreamController.add(
            [message, ...state.requireValue],
          );
        }
      },
    );
  }
}
