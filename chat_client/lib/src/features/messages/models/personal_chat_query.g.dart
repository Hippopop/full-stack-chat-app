// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_chat_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalChatQueryImpl _$$PersonalChatQueryImplFromJson(
        Map<String, dynamic> json) =>
    _$PersonalChatQueryImpl(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      birthdate: json['birthdate'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      activityStatus: json['activityStatus'] as String?,
    );

Map<String, dynamic> _$$PersonalChatQueryImplToJson(
        _$PersonalChatQueryImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'name': instance.name,
      'photo': instance.photo,
      'birthdate': instance.birthdate,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'activityStatus': instance.activityStatus,
    };
