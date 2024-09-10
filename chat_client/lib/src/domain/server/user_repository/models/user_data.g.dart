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
      connection: json['connection'] == null
          ? null
          : ConnectionData.fromJson(json['connection'] as Map<String, dynamic>),
      uuid: json['uuid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      createdAt: _$JsonConverterFromJson<int, DateTime>(
          json['createdAt'], const EpochSecondsDateTimeConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<int, DateTime>(
          json['updatedAt'], const EpochSecondsDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'photo': instance.photo,
      'birthdate': instance.birthdate,
      'connection': instance.connection,
      'uuid': instance.uuid,
      'email': instance.email,
      'name': instance.name,
      'createdAt': _$JsonConverterToJson<int, DateTime>(
          instance.createdAt, const EpochSecondsDateTimeConverter().toJson),
      'updatedAt': _$JsonConverterToJson<int, DateTime>(
          instance.updatedAt, const EpochSecondsDateTimeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
