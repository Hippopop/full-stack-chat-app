// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppUserState _$AppUserStateFromJson(Map<String, dynamic> json) {
  return _AppUserState.fromJson(json);
}

/// @nodoc
mixin _$AppUserState {
  AppUser? get currentUser => throw _privateConstructorUsedError;
  ({String accessToken, String refreshToken})? get token =>
      throw _privateConstructorUsedError;

  /// Serializes this AppUserState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppUserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppUserStateCopyWith<AppUserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserStateCopyWith<$Res> {
  factory $AppUserStateCopyWith(
          AppUserState value, $Res Function(AppUserState) then) =
      _$AppUserStateCopyWithImpl<$Res, AppUserState>;
  @useResult
  $Res call(
      {AppUser? currentUser,
      ({String accessToken, String refreshToken})? token});

  $AppUserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$AppUserStateCopyWithImpl<$Res, $Val extends AppUserState>
    implements $AppUserStateCopyWith<$Res> {
  _$AppUserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppUserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUser = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as AppUser?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as ({String accessToken, String refreshToken})?,
    ) as $Val);
  }

  /// Create a copy of AppUserState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res>? get currentUser {
    if (_value.currentUser == null) {
      return null;
    }

    return $AppUserCopyWith<$Res>(_value.currentUser!, (value) {
      return _then(_value.copyWith(currentUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppUserStateImplCopyWith<$Res>
    implements $AppUserStateCopyWith<$Res> {
  factory _$$AppUserStateImplCopyWith(
          _$AppUserStateImpl value, $Res Function(_$AppUserStateImpl) then) =
      __$$AppUserStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AppUser? currentUser,
      ({String accessToken, String refreshToken})? token});

  @override
  $AppUserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$$AppUserStateImplCopyWithImpl<$Res>
    extends _$AppUserStateCopyWithImpl<$Res, _$AppUserStateImpl>
    implements _$$AppUserStateImplCopyWith<$Res> {
  __$$AppUserStateImplCopyWithImpl(
      _$AppUserStateImpl _value, $Res Function(_$AppUserStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppUserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUser = freezed,
    Object? token = freezed,
  }) {
    return _then(_$AppUserStateImpl(
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as AppUser?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as ({String accessToken, String refreshToken})?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUserStateImpl extends _AppUserState with DiagnosticableTreeMixin {
  const _$AppUserStateImpl({this.currentUser, this.token}) : super._();

  factory _$AppUserStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserStateImplFromJson(json);

  @override
  final AppUser? currentUser;
  @override
  final ({String accessToken, String refreshToken})? token;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppUserState(currentUser: $currentUser, token: $token)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppUserState'))
      ..add(DiagnosticsProperty('currentUser', currentUser))
      ..add(DiagnosticsProperty('token', token));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserStateImpl &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentUser, token);

  /// Create a copy of AppUserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserStateImplCopyWith<_$AppUserStateImpl> get copyWith =>
      __$$AppUserStateImplCopyWithImpl<_$AppUserStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserStateImplToJson(
      this,
    );
  }
}

abstract class _AppUserState extends AppUserState {
  const factory _AppUserState(
          {final AppUser? currentUser,
          final ({String accessToken, String refreshToken})? token}) =
      _$AppUserStateImpl;
  const _AppUserState._() : super._();

  factory _AppUserState.fromJson(Map<String, dynamic> json) =
      _$AppUserStateImpl.fromJson;

  @override
  AppUser? get currentUser;
  @override
  ({String accessToken, String refreshToken})? get token;

  /// Create a copy of AppUserState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppUserStateImplCopyWith<_$AppUserStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
