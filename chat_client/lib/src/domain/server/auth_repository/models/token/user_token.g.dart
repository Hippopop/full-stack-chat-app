// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserTokenImpl _$$UserTokenImplFromJson(Map<String, dynamic> json) =>
    _$UserTokenImpl(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresAt: const EpochSecondsDateTimeConverter()
          .fromJson((json['expiresAt'] as num).toInt()),
    );

Map<String, dynamic> _$$UserTokenImplToJson(_$UserTokenImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'expiresAt':
          const EpochSecondsDateTimeConverter().toJson(instance.expiresAt),
    };
