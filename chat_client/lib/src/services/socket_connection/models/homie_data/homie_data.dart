import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:chat_client/src/constants/utils/json_date_convert.dart';
import 'package:chat_client/src/domain/server/user_repository/models/connection_data.dart';
import 'package:chat_client/src/services/socket_connection/models/message/user_message.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'homie_data.freezed.dart';
part 'homie_data.g.dart';

@freezed
class HomieData with _$HomieData {
  const factory HomieData({
    UserMessage? message,
    required HomieInfo homie,
    required ConnectionInfo connection,
  }) = _HomieData;

  factory HomieData.fromJson(Map<String, Object?> json) =>
      _$HomieDataFromJson(json);
}

@freezed
class HomieInfo with _$HomieInfo {
  const factory HomieInfo({
    required String uuid,
    required String name,
    String? photo,
    @Default(false) bool isActive,
    @EpochSecondsDateTimeConverter() DateTime? lastActivity,
  }) = _HomieInfo;

  const HomieInfo._();
  String? get photoUrl => photo == null ? null : "${APIConfig.baseURL}$photo";

  factory HomieInfo.fromJson(Map<String, Object?> json) =>
      _$HomieInfoFromJson(json);
}

@freezed
class ConnectionInfo with _$ConnectionInfo {
  const factory ConnectionInfo({
    required int key,
    required ConnectionStatus status,
    @EpochSecondsDateTimeConverter() DateTime? acceptedAt,
  }) = _ConnectionInfo;

  factory ConnectionInfo.fromJson(Map<String, Object?> json) =>
      _$ConnectionInfoFromJson(json);
}
