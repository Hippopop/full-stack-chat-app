import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_chat_query.freezed.dart';
part 'personal_chat_query.g.dart';

@freezed
class PersonalChatQuery with _$PersonalChatQuery {
  const factory PersonalChatQuery({
    String? email,
    String? phone,
    String? name,
    String? photo,
    String? birthdate,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? activityStatus,
  }) = _PersonalChatQuery;

  const PersonalChatQuery._();

  String? get photoUrl => photo == null ? null : "${APIConfig.baseURL}$photo";

  factory PersonalChatQuery.fromJson(Map<String, Object?> json) =>
      _$PersonalChatQueryFromJson(json);
}
