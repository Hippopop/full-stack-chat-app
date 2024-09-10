import 'package:chat_client/src/domain/storage/auth_repository/auth_storage.dart';
import 'package:chat_client/src/services/authentication/models/app_user_state.dart';
import 'package:chat_client/src/utilities/scaffold_utils/snackbar_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_dio/fresh_dio.dart';

import '../../domain/server/auth_repository/auth_repository.dart';

typedef _AuthorizationState = ({String? currentUuid, bool isAuthorized});
final authorizationProvider = StateProvider<_AuthorizationState>((ref) {
  final uuid = ref.watch(
    userStateNotifierProvider.select((value) => value.currentUser?.uuid),
  );
  final isAuthorized = ref.watch(
    userStateNotifierProvider.select((value) => value.isAuthenticated),
  );
  return (currentUuid: uuid, isAuthorized: isAuthorized);
});

/// Provides the all the info related to the current [AppUser].
final userStateNotifierProvider =
    NotifierProvider<AuthenticationStateNotifier, AppUserState>(
  AuthenticationStateNotifier.new,
);

class AuthenticationStateNotifier extends Notifier<AppUserState>
    implements TokenStorage<OAuth2Token> {
  late final AuthenticationStorage _storage = const AuthenticationStorage();

  @override
  build() {
    final tokens = _storage.getUserToken();
    final user = _storage.getCurrentUser();
    return AppUserState(token: tokens, currentUser: user);
  }

  logout() async {
    await _storage.delete();
    ref.invalidateSelf();
    showToastSuccess("User logged out successfully!");
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
    final tokenSet = _storage.getUserToken();
    if (tokenSet == null) return null;
    return OAuth2Token(
      accessToken: tokenSet.accessToken,
      refreshToken: tokenSet.refreshToken,
    );
  }

  @override
  Future<void> write(OAuth2Token token) async {
    await _storage.saveUserToken(token.accessToken, token.refreshToken!);
    ref.invalidateSelf();
  }
}
