import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:chat_client/src/repositories/server/auth_repository/auth_repository.dart';
import 'package:chat_client/src/repositories/server/source/helpers/response_wrapper.dart';
import 'package:chat_client/src/repositories/storage/auth_repository/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_dio/fresh_dio.dart';

final tokenInterceptorProvider =
    NotifierProvider<TokenInterceptorNotifier, Interceptor>(
  TokenInterceptorNotifier.new,
);

class TokenInterceptorNotifier extends Notifier<Interceptor> {
  @override
  Interceptor build() {
    final storage = ref.watch(tokenStorageNotifierProvider.notifier);
    return Fresh.oAuth2(
      tokenStorage: storage,
      shouldRefresh: (response) => response?.statusCode == 401,
      httpClient: Dio(
        BaseOptions(
          baseUrl: APIConfig.baseURL,
          receiveDataWhenStatusError: true,
          validateStatus: (status) => true,
        ),
      ),
      refreshToken: (token, httpClient) async {
        final res = await httpClient.post(APIConfig.refresh, data: {
          'token': token?.accessToken,
          'refreshToken': token?.refreshToken,
        });
        final wrapper = ResponseWrapper<UserToken>.fromMap(
          rawResponse: res,
          purserFunction: (json) => UserToken.fromJson(json),
        );
        return wrapper.data!.toOAuth2Token;
      },
    );
  }

  Future<void> saveNewUserToken(UserToken token) async {
    final storage = ref.read(tokenStorageNotifierProvider.notifier);
    await storage.saveUserToken(token);
    ref.invalidateSelf();
  }
}
