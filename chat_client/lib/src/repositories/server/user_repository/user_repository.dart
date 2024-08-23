import 'package:chat_client/src/repositories/server/user_repository/models/connection_data.dart';

import '../../repository.dart';
export 'models/user_data.dart';

abstract class UserRepository {
  final RequestHandler requestHandler;

  UserRepository({
    required this.requestHandler,
  });

  Future<ResponseWrapper<List<UserData>>> searchUsers({required String query});

  Future<ResponseWrapper<ConnectionData>> requestConnection({
    required String userUUID,
  });

  Future<ResponseWrapper<ConnectionData>> updateUserConnection({
    required int connectionKey,
    required ConnectionStatus newStatus,
  });
}
