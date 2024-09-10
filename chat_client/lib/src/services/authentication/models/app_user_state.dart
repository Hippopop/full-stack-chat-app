import 'package:chat_client/src/domain/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_state.freezed.dart';
part 'app_user_state.g.dart';

@freezed
class AppUserState with _$AppUserState {
  const factory AppUserState({
    AppUser? currentUser,
    ({String accessToken, String refreshToken})? token,
  }) = _AppUserState;

  const AppUserState._();
  bool get isAuthenticated => token != null && currentUser != null;

  factory AppUserState.fromJson(Map<String, Object?> json) =>
      _$AppUserStateFromJson(json);
}
