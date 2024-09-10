// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserStateImpl _$$AppUserStateImplFromJson(Map<String, dynamic> json) =>
    _$AppUserStateImpl(
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

Map<String, dynamic> _$$AppUserStateImplToJson(_$AppUserStateImpl instance) =>
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
