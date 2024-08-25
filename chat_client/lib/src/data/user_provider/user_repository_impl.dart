import 'package:dio/dio.dart';
import 'package:chat_client/src/repositories/repository.dart';
import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:chat_client/src/repositories/server/user_repository/models/connection_data.dart';

class UserProvider extends UserRepository {
  UserProvider({required super.requestHandler});

  @override
  Future<ResponseWrapper<List<UserData>>> searchUsers({
    required String query,
    CancelToken? cancelToken,
  }) async {
    final response = await requestHandler.get(
      APIConfig.searchUser,
      cancelToken: cancelToken,
      queryParams: {'query': query},
    );

    return ResponseWrapper<List<UserData>>.fromMap(
      rawResponse: response,
      purserFunction: (rawData) =>
          (rawData as List).map((e) => UserData.fromJson(e)).toList(),
    );
  }

  @override
  Future<ResponseWrapper<ConnectionData>> requestConnection({
    required String userUUID,
    CancelToken? cancelToken,
  }) async {
    final response = await requestHandler.post(
      APIConfig.requestConnection + userUUID,
      cancelToken: cancelToken,
      {},
    );

    return ResponseWrapper<ConnectionData>.fromMap(
      rawResponse: response,
      purserFunction: (rawData) => ConnectionData.fromJson(rawData),
    );
  }

  @override
  Future<ResponseWrapper<ConnectionData>> updateUserConnection({
    required int connectionKey,
    required ConnectionStatus newStatus,
    CancelToken? cancelToken,
  }) async {
    final response = await requestHandler.post(
      APIConfig.updateConnection + connectionKey.toString(),
      {'status': newStatus.name},
      cancelToken: cancelToken,
    );

    return ResponseWrapper<ConnectionData>.fromMap(
      rawResponse: response,
      purserFunction: (rawData) => ConnectionData.fromJson(rawData),
    );
  }
}
