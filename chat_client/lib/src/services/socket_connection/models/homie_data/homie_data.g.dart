// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homie_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomieDataImpl _$$HomieDataImplFromJson(Map<String, dynamic> json) =>
    _$HomieDataImpl(
      message: json['message'] == null
          ? null
          : UserMessage.fromJson(json['message'] as Map<String, dynamic>),
      homie: HomieInfo.fromJson(json['homie'] as Map<String, dynamic>),
      connection:
          ConnectionInfo.fromJson(json['connection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HomieDataImplToJson(_$HomieDataImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'homie': instance.homie,
      'connection': instance.connection,
    };

_$HomieInfoImpl _$$HomieInfoImplFromJson(Map<String, dynamic> json) =>
    _$HomieInfoImpl(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      photo: json['photo'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      lastActivity: _$JsonConverterFromJson<int, DateTime>(
          json['lastActivity'], const EpochSecondsDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$HomieInfoImplToJson(_$HomieInfoImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'photo': instance.photo,
      'isActive': instance.isActive,
      'lastActivity': _$JsonConverterToJson<int, DateTime>(
          instance.lastActivity, const EpochSecondsDateTimeConverter().toJson),
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

_$ConnectionInfoImpl _$$ConnectionInfoImplFromJson(Map<String, dynamic> json) =>
    _$ConnectionInfoImpl(
      key: (json['key'] as num).toInt(),
      status: $enumDecode(_$ConnectionStatusEnumMap, json['status']),
      acceptedAt: _$JsonConverterFromJson<int, DateTime>(
          json['acceptedAt'], const EpochSecondsDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$ConnectionInfoImplToJson(
        _$ConnectionInfoImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'status': _$ConnectionStatusEnumMap[instance.status]!,
      'acceptedAt': _$JsonConverterToJson<int, DateTime>(
          instance.acceptedAt, const EpochSecondsDateTimeConverter().toJson),
    };

const _$ConnectionStatusEnumMap = {
  ConnectionStatus.requested: 'requested',
  ConnectionStatus.accepted: 'accepted',
  ConnectionStatus.rejected: 'rejected',
  ConnectionStatus.blocked: 'blocked',
};
