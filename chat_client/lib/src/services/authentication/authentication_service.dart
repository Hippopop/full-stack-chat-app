import 'package:chat_client/src/repositories/storage/auth_repository/auth_storage.dart';
import 'package:chat_client/src/services/authentication/models/app_authentication.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_dio/fresh_dio.dart';

import '../../repositories/server/auth_repository/auth_repository.dart';

final authStateNotifierProvider =
    NotifierProvider<AuthenticationStateNotifier, AuthenticationState>(
  AuthenticationStateNotifier.new,
);

class AuthenticationStateNotifier extends Notifier<AuthenticationState>
    implements TokenStorage<OAuth2Token> {
  late final AuthenticationStorage _storage = const AuthenticationStorage();

  @override
  build() {
    final tokens = _storage.getUserToken();
    final user = _storage.getCurrentUser();
    return AuthenticationState(token: tokens, currentUser: user);
  }

  Future<void> saveAppUser(AppUser newUser) async {
    await _storage.saveAppUser(newUser);
    ref.invalidateSelf();
  }

  Future<void> saveUserToken(UserToken userToken) async =>
      await write(userToken.toOAuth2Token);

  @override
  Future<void> delete() async {
    await _storage.clearTokens();
    ref.invalidateSelf();
  }

  @override
  Future<OAuth2Token?> read() async {
    print("Token Reading");
    final tokenSet = _storage.getUserToken();
    if (tokenSet == null) return null;
    return OAuth2Token(
        accessToken: tokenSet.accessToken, refreshToken: tokenSet.refreshToken);
  }

  @override
  Future<void> write(OAuth2Token token) async {
    print("Token Writing");
    await _storage.saveUserToken(token.accessToken, token.refreshToken!);
    ref.invalidateSelf();
  }
}
