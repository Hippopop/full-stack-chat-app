import 'package:chat_client/src/services/socket_connection/models/message/user_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../socket_isolate/providers/message_socket_provider.dart';

final userMessagesProvider = StreamNotifierProviderFamily<
    UserMessageStreamNotifier, List<UserMessage>, String>(
  UserMessageStreamNotifier.new,
);

class UserMessageStreamNotifier
    extends FamilyStreamNotifier<List<UserMessage>, String> {
  @override
  build(arg) async* {
    final socket = await ref.watch(chatSocketProvider(arg).future);
    yield* socket.state.dataStreamController.stream;
  }
}
