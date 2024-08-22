// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    _$UserDataImpl(
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      birthdate: json['birthdate'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      uuid: json['uuid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'photo': instance.photo,
      'birthdate': instance.birthdate,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'uuid': instance.uuid,
      'email': instance.email,
      'name': instance.name,
    };
