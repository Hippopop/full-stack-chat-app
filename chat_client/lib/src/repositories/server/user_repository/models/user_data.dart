import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
class UserData with _$UserData {
  const factory UserData({
    String? phone,
    String? photo,
    String? birthdate,
    DateTime? createdAt,
    DateTime? updatedAt,
    required String uuid,
    required String email,
    required String name,
  }) = _UserData;

  const UserData._();

  String? get photoUrl => photo == null ? null : "${APIConfig.baseURL}$photo";

  factory UserData.fromJson(Map<String, Object?> json) =>
      _$UserDataFromJson(json);
}
