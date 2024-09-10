// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectionDataImpl _$$ConnectionDataImplFromJson(Map<String, dynamic> json) =>
    _$ConnectionDataImpl(
      lastMessage: (json['lastMessage'] as num?)?.toInt(),
      acceptTime: json['acceptTime'] as String?,
      key: (json['key'] as num).toInt(),
      toUser: json['toUser'] as String,
      fromUser: json['fromUser'] as String,
      connectionStatus:
          $enumDecode(_$ConnectionStatusEnumMap, json['connectionStatus']),
      createdAt: _$JsonConverterFromJson<int, DateTime>(
          json['createdAt'], const EpochSecondsDateTimeConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<int, DateTime>(
          json['updatedAt'], const EpochSecondsDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$ConnectionDataImplToJson(
        _$ConnectionDataImpl instance) =>
    <String, dynamic>{
      'lastMessage': instance.lastMessage,
      'acceptTime': instance.acceptTime,
      'key': instance.key,
      'toUser': instance.toUser,
      'fromUser': instance.fromUser,
      'connectionStatus': _$ConnectionStatusEnumMap[instance.connectionStatus]!,
      'createdAt': _$JsonConverterToJson<int, DateTime>(
          instance.createdAt, const EpochSecondsDateTimeConverter().toJson),
      'updatedAt': _$JsonConverterToJson<int, DateTime>(
          instance.updatedAt, const EpochSecondsDateTimeConverter().toJson),
    };

const _$ConnectionStatusEnumMap = {
  ConnectionStatus.requested: 'requested',
  ConnectionStatus.accepted: 'accepted',
  ConnectionStatus.rejected: 'rejected',
  ConnectionStatus.blocked: 'blocked',
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
