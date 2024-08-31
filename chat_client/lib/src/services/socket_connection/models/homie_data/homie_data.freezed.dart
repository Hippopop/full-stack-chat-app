// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homie_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomieData _$HomieDataFromJson(Map<String, dynamic> json) {
  return _HomieData.fromJson(json);
}

/// @nodoc
mixin _$HomieData {
  UserMessage? get message => throw _privateConstructorUsedError;
  HomieInfo get homie => throw _privateConstructorUsedError;
  ConnectionInfo get connection => throw _privateConstructorUsedError;

  /// Serializes this HomieData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomieData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomieDataCopyWith<HomieData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomieDataCopyWith<$Res> {
  factory $HomieDataCopyWith(HomieData value, $Res Function(HomieData) then) =
      _$HomieDataCopyWithImpl<$Res, HomieData>;
  @useResult
  $Res call({UserMessage? message, HomieInfo homie, ConnectionInfo connection});

  $UserMessageCopyWith<$Res>? get message;
  $HomieInfoCopyWith<$Res> get homie;
  $ConnectionInfoCopyWith<$Res> get connection;
}

/// @nodoc
class _$HomieDataCopyWithImpl<$Res, $Val extends HomieData>
    implements $HomieDataCopyWith<$Res> {
  _$HomieDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomieData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? homie = null,
    Object? connection = null,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as UserMessage?,
      homie: null == homie
          ? _value.homie
          : homie // ignore: cast_nullable_to_non_nullable
              as HomieInfo,
      connection: null == connection
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as ConnectionInfo,
    ) as $Val);
  }

  /// Create a copy of HomieData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserMessageCopyWith<$Res>? get message {
    if (_value.message == null) {
      return null;
    }

    return $UserMessageCopyWith<$Res>(_value.message!, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }

  /// Create a copy of HomieData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HomieInfoCopyWith<$Res> get homie {
    return $HomieInfoCopyWith<$Res>(_value.homie, (value) {
      return _then(_value.copyWith(homie: value) as $Val);
    });
  }

  /// Create a copy of HomieData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionInfoCopyWith<$Res> get connection {
    return $ConnectionInfoCopyWith<$Res>(_value.connection, (value) {
      return _then(_value.copyWith(connection: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomieDataImplCopyWith<$Res>
    implements $HomieDataCopyWith<$Res> {
  factory _$$HomieDataImplCopyWith(
          _$HomieDataImpl value, $Res Function(_$HomieDataImpl) then) =
      __$$HomieDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserMessage? message, HomieInfo homie, ConnectionInfo connection});

  @override
  $UserMessageCopyWith<$Res>? get message;
  @override
  $HomieInfoCopyWith<$Res> get homie;
  @override
  $ConnectionInfoCopyWith<$Res> get connection;
}

/// @nodoc
class __$$HomieDataImplCopyWithImpl<$Res>
    extends _$HomieDataCopyWithImpl<$Res, _$HomieDataImpl>
    implements _$$HomieDataImplCopyWith<$Res> {
  __$$HomieDataImplCopyWithImpl(
      _$HomieDataImpl _value, $Res Function(_$HomieDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomieData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? homie = null,
    Object? connection = null,
  }) {
    return _then(_$HomieDataImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as UserMessage?,
      homie: null == homie
          ? _value.homie
          : homie // ignore: cast_nullable_to_non_nullable
              as HomieInfo,
      connection: null == connection
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as ConnectionInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomieDataImpl with DiagnosticableTreeMixin implements _HomieData {
  const _$HomieDataImpl(
      {this.message, required this.homie, required this.connection});

  factory _$HomieDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomieDataImplFromJson(json);

  @override
  final UserMessage? message;
  @override
  final HomieInfo homie;
  @override
  final ConnectionInfo connection;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomieData(message: $message, homie: $homie, connection: $connection)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomieData'))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('homie', homie))
      ..add(DiagnosticsProperty('connection', connection));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomieDataImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.homie, homie) || other.homie == homie) &&
            (identical(other.connection, connection) ||
                other.connection == connection));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, homie, connection);

  /// Create a copy of HomieData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomieDataImplCopyWith<_$HomieDataImpl> get copyWith =>
      __$$HomieDataImplCopyWithImpl<_$HomieDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomieDataImplToJson(
      this,
    );
  }
}

abstract class _HomieData implements HomieData {
  const factory _HomieData(
      {final UserMessage? message,
      required final HomieInfo homie,
      required final ConnectionInfo connection}) = _$HomieDataImpl;

  factory _HomieData.fromJson(Map<String, dynamic> json) =
      _$HomieDataImpl.fromJson;

  @override
  UserMessage? get message;
  @override
  HomieInfo get homie;
  @override
  ConnectionInfo get connection;

  /// Create a copy of HomieData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomieDataImplCopyWith<_$HomieDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HomieInfo _$HomieInfoFromJson(Map<String, dynamic> json) {
  return _HomieInfo.fromJson(json);
}

/// @nodoc
mixin _$HomieInfo {
  String get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  @EpochSecondsDateTimeConverter()
  DateTime? get lastActivity => throw _privateConstructorUsedError;

  /// Serializes this HomieInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomieInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomieInfoCopyWith<HomieInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomieInfoCopyWith<$Res> {
  factory $HomieInfoCopyWith(HomieInfo value, $Res Function(HomieInfo) then) =
      _$HomieInfoCopyWithImpl<$Res, HomieInfo>;
  @useResult
  $Res call(
      {String uuid,
      String name,
      String? photo,
      bool? isActive,
      @EpochSecondsDateTimeConverter() DateTime? lastActivity});
}

/// @nodoc
class _$HomieInfoCopyWithImpl<$Res, $Val extends HomieInfo>
    implements $HomieInfoCopyWith<$Res> {
  _$HomieInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomieInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? photo = freezed,
    Object? isActive = freezed,
    Object? lastActivity = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastActivity: freezed == lastActivity
          ? _value.lastActivity
          : lastActivity // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomieInfoImplCopyWith<$Res>
    implements $HomieInfoCopyWith<$Res> {
  factory _$$HomieInfoImplCopyWith(
          _$HomieInfoImpl value, $Res Function(_$HomieInfoImpl) then) =
      __$$HomieInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uuid,
      String name,
      String? photo,
      bool? isActive,
      @EpochSecondsDateTimeConverter() DateTime? lastActivity});
}

/// @nodoc
class __$$HomieInfoImplCopyWithImpl<$Res>
    extends _$HomieInfoCopyWithImpl<$Res, _$HomieInfoImpl>
    implements _$$HomieInfoImplCopyWith<$Res> {
  __$$HomieInfoImplCopyWithImpl(
      _$HomieInfoImpl _value, $Res Function(_$HomieInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomieInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? photo = freezed,
    Object? isActive = freezed,
    Object? lastActivity = freezed,
  }) {
    return _then(_$HomieInfoImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastActivity: freezed == lastActivity
          ? _value.lastActivity
          : lastActivity // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomieInfoImpl extends _HomieInfo with DiagnosticableTreeMixin {
  const _$HomieInfoImpl(
      {required this.uuid,
      required this.name,
      this.photo,
      this.isActive,
      @EpochSecondsDateTimeConverter() this.lastActivity})
      : super._();

  factory _$HomieInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomieInfoImplFromJson(json);

  @override
  final String uuid;
  @override
  final String name;
  @override
  final String? photo;
  @override
  final bool? isActive;
  @override
  @EpochSecondsDateTimeConverter()
  final DateTime? lastActivity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomieInfo(uuid: $uuid, name: $name, photo: $photo, isActive: $isActive, lastActivity: $lastActivity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomieInfo'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('photo', photo))
      ..add(DiagnosticsProperty('isActive', isActive))
      ..add(DiagnosticsProperty('lastActivity', lastActivity));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomieInfoImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.lastActivity, lastActivity) ||
                other.lastActivity == lastActivity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uuid, name, photo, isActive, lastActivity);

  /// Create a copy of HomieInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomieInfoImplCopyWith<_$HomieInfoImpl> get copyWith =>
      __$$HomieInfoImplCopyWithImpl<_$HomieInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomieInfoImplToJson(
      this,
    );
  }
}

abstract class _HomieInfo extends HomieInfo {
  const factory _HomieInfo(
          {required final String uuid,
          required final String name,
          final String? photo,
          final bool? isActive,
          @EpochSecondsDateTimeConverter() final DateTime? lastActivity}) =
      _$HomieInfoImpl;
  const _HomieInfo._() : super._();

  factory _HomieInfo.fromJson(Map<String, dynamic> json) =
      _$HomieInfoImpl.fromJson;

  @override
  String get uuid;
  @override
  String get name;
  @override
  String? get photo;
  @override
  bool? get isActive;
  @override
  @EpochSecondsDateTimeConverter()
  DateTime? get lastActivity;

  /// Create a copy of HomieInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomieInfoImplCopyWith<_$HomieInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConnectionInfo _$ConnectionInfoFromJson(Map<String, dynamic> json) {
  return _ConnectionInfo.fromJson(json);
}

/// @nodoc
mixin _$ConnectionInfo {
  int get key => throw _privateConstructorUsedError;
  ConnectionStatus get status => throw _privateConstructorUsedError;
  @EpochSecondsDateTimeConverter()
  DateTime? get acceptedAt => throw _privateConstructorUsedError;

  /// Serializes this ConnectionInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionInfoCopyWith<ConnectionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionInfoCopyWith<$Res> {
  factory $ConnectionInfoCopyWith(
          ConnectionInfo value, $Res Function(ConnectionInfo) then) =
      _$ConnectionInfoCopyWithImpl<$Res, ConnectionInfo>;
  @useResult
  $Res call(
      {int key,
      ConnectionStatus status,
      @EpochSecondsDateTimeConverter() DateTime? acceptedAt});
}

/// @nodoc
class _$ConnectionInfoCopyWithImpl<$Res, $Val extends ConnectionInfo>
    implements $ConnectionInfoCopyWith<$Res> {
  _$ConnectionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? status = null,
    Object? acceptedAt = freezed,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ConnectionStatus,
      acceptedAt: freezed == acceptedAt
          ? _value.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectionInfoImplCopyWith<$Res>
    implements $ConnectionInfoCopyWith<$Res> {
  factory _$$ConnectionInfoImplCopyWith(_$ConnectionInfoImpl value,
          $Res Function(_$ConnectionInfoImpl) then) =
      __$$ConnectionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int key,
      ConnectionStatus status,
      @EpochSecondsDateTimeConverter() DateTime? acceptedAt});
}

/// @nodoc
class __$$ConnectionInfoImplCopyWithImpl<$Res>
    extends _$ConnectionInfoCopyWithImpl<$Res, _$ConnectionInfoImpl>
    implements _$$ConnectionInfoImplCopyWith<$Res> {
  __$$ConnectionInfoImplCopyWithImpl(
      _$ConnectionInfoImpl _value, $Res Function(_$ConnectionInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? status = null,
    Object? acceptedAt = freezed,
  }) {
    return _then(_$ConnectionInfoImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ConnectionStatus,
      acceptedAt: freezed == acceptedAt
          ? _value.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionInfoImpl
    with DiagnosticableTreeMixin
    implements _ConnectionInfo {
  const _$ConnectionInfoImpl(
      {required this.key,
      required this.status,
      @EpochSecondsDateTimeConverter() this.acceptedAt});

  factory _$ConnectionInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionInfoImplFromJson(json);

  @override
  final int key;
  @override
  final ConnectionStatus status;
  @override
  @EpochSecondsDateTimeConverter()
  final DateTime? acceptedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConnectionInfo(key: $key, status: $status, acceptedAt: $acceptedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConnectionInfo'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('acceptedAt', acceptedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionInfoImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.acceptedAt, acceptedAt) ||
                other.acceptedAt == acceptedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key, status, acceptedAt);

  /// Create a copy of ConnectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionInfoImplCopyWith<_$ConnectionInfoImpl> get copyWith =>
      __$$ConnectionInfoImplCopyWithImpl<_$ConnectionInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionInfoImplToJson(
      this,
    );
  }
}

abstract class _ConnectionInfo implements ConnectionInfo {
  const factory _ConnectionInfo(
          {required final int key,
          required final ConnectionStatus status,
          @EpochSecondsDateTimeConverter() final DateTime? acceptedAt}) =
      _$ConnectionInfoImpl;

  factory _ConnectionInfo.fromJson(Map<String, dynamic> json) =
      _$ConnectionInfoImpl.fromJson;

  @override
  int get key;
  @override
  ConnectionStatus get status;
  @override
  @EpochSecondsDateTimeConverter()
  DateTime? get acceptedAt;

  /// Create a copy of ConnectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionInfoImplCopyWith<_$ConnectionInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
