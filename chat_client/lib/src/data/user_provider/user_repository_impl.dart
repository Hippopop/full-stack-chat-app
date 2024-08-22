import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:chat_client/src/repositories/repository.dart';
import 'package:dio/dio.dart';

class UserProvider extends UserRepository {
  UserProvider({required super.requestHandler});

  @override
  Future<ResponseWrapper<List<UserData>>> searchUsers({
    required String query,
    CancelToken? cancelToken,
  }) async {
    final raw = await requestHandler.get(
      APIConfig.searchUser,
      cancelToken: cancelToken,
      queryParams: {'query': query},
    );

    return ResponseWrapper<List<UserData>>.fromMap(
      rawResponse: raw,
      purserFunction: (rawData) =>
          (rawData as List).map((e) => UserData.fromJson(e)).toList(),
    );
  }
}
