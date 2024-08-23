// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectionDataImpl _$$ConnectionDataImplFromJson(Map<String, dynamic> json) =>
    _$ConnectionDataImpl(
      acceptTime: json['acceptTime'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      key: (json['key'] as num).toInt(),
      toUser: json['toUser'] as String,
      fromUser: json['fromUser'] as String,
      connectionStatus:
          $enumDecode(_$ConnectionStatusEnumMap, json['connectionStatus']),
    );

Map<String, dynamic> _$$ConnectionDataImplToJson(
        _$ConnectionDataImpl instance) =>
    <String, dynamic>{
      'acceptTime': instance.acceptTime,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'key': instance.key,
      'toUser': instance.toUser,
      'fromUser': instance.fromUser,
      'connectionStatus': _$ConnectionStatusEnumMap[instance.connectionStatus]!,
    };

const _$ConnectionStatusEnumMap = {
  ConnectionStatus.requested: 'requested',
  ConnectionStatus.accepted: 'accepted',
  ConnectionStatus.rejected: 'rejected',
  ConnectionStatus.blocked: 'blocked',
};
