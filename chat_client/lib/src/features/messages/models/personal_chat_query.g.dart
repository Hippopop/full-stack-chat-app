// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_chat_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalChatQueryImpl _$$PersonalChatQueryImplFromJson(
        Map<String, dynamic> json) =>
    _$PersonalChatQueryImpl(
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      isActive: json['isActive'] as bool?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PersonalChatQueryImplToJson(
        _$PersonalChatQueryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'photo': instance.photo,
      'isActive': instance.isActive,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
