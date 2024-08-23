// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_authentication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthenticationStateImpl _$$AuthenticationStateImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthenticationStateImpl(
      currentUser: json['currentUser'] == null
          ? null
          : AppUser.fromJson(json['currentUser'] as Map<String, dynamic>),
      token: _$recordConvertNullable(
        json['token'],
        ($jsonValue) => (
          accessToken: $jsonValue['accessToken'] as String,
          refreshToken: $jsonValue['refreshToken'] as String,
        ),
      ),
    );

Map<String, dynamic> _$$AuthenticationStateImplToJson(
        _$AuthenticationStateImpl instance) =>
    <String, dynamic>{
      'currentUser': instance.currentUser,
      'token': instance.token == null
          ? null
          : <String, dynamic>{
              'accessToken': instance.token!.accessToken,
              'refreshToken': instance.token!.refreshToken,
            },
    };

$Rec? _$recordConvertNullable<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    value == null ? null : convert(value as Map<String, dynamic>);
