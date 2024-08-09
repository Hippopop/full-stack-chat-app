import 'package:chat_client/src/repositories/storage/config/hive_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:hive/hive.dart';

import '../../server/auth_repository/auth_repository.dart';

typedef TokenRecord = ({String? accessToken, String? refreshToken});

final tokenStorageNotifierProvider =
    NotifierProvider<HiveTokenStorageNotifier, TokenRecord>(
  HiveTokenStorageNotifier.new,
);

class HiveTokenStorageNotifier extends Notifier<TokenRecord>
    implements TokenStorage<OAuth2Token> {
  late final _hiveConfig = HiveConfig();

  Box<String> get _myBox => _hiveConfig.tokenBox;
  static const accessTokenKey = "#ACCESS_TOKEN";
  static const refreshTokenKey = "#REFRESH_TOKEN";

  @override
  build() {
    return (
      accessToken: _myBox.get(accessTokenKey),
      refreshToken: _myBox.get(refreshTokenKey)
    );
  }

  Future<void> saveUserToken(UserToken userToken) async =>
      await write(userToken.toOAuth2Token);

  @override
  Future<void> delete() async {
    await _myBox.clear();
    ref.invalidateSelf();
  }

  @override
  Future<OAuth2Token?> read() async {
    print("Reading");
    final access = _myBox.get(accessTokenKey);
    final refresh = _myBox.get(refreshTokenKey);
    print((access: access, refresh: refresh));
    if (access == null || refresh == null) return null;
    return OAuth2Token(accessToken: access, refreshToken: refresh);
  }

  @override
  Future<void> write(OAuth2Token token) async {
    print("Writing");
    await _myBox.put(accessTokenKey, token.accessToken);
    await _myBox.put(refreshTokenKey, token.refreshToken!);
    ref.invalidateSelf();
  }
}
