// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConnectionData _$ConnectionDataFromJson(Map<String, dynamic> json) {
  return _ConnectionData.fromJson(json);
}

/// @nodoc
mixin _$ConnectionData {
  int? get lastMessage => throw _privateConstructorUsedError;
  String? get acceptTime => throw _privateConstructorUsedError;
  int get key => throw _privateConstructorUsedError;
  String get toUser => throw _privateConstructorUsedError;
  String get fromUser => throw _privateConstructorUsedError;
  ConnectionStatus get connectionStatus => throw _privateConstructorUsedError;
  @EpochSecondsDateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @EpochSecondsDateTimeConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ConnectionData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionDataCopyWith<ConnectionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionDataCopyWith<$Res> {
  factory $ConnectionDataCopyWith(
          ConnectionData value, $Res Function(ConnectionData) then) =
      _$ConnectionDataCopyWithImpl<$Res, ConnectionData>;
  @useResult
  $Res call(
      {int? lastMessage,
      String? acceptTime,
      int key,
      String toUser,
      String fromUser,
      ConnectionStatus connectionStatus,
      @EpochSecondsDateTimeConverter() DateTime? createdAt,
      @EpochSecondsDateTimeConverter() DateTime? updatedAt});
}

/// @nodoc
class _$ConnectionDataCopyWithImpl<$Res, $Val extends ConnectionData>
    implements $ConnectionDataCopyWith<$Res> {
  _$ConnectionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastMessage = freezed,
    Object? acceptTime = freezed,
    Object? key = null,
    Object? toUser = null,
    Object? fromUser = null,
    Object? connectionStatus = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as int?,
      acceptTime: freezed == acceptTime
          ? _value.acceptTime
          : acceptTime // ignore: cast_nullable_to_non_nullable
              as String?,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as int,
      toUser: null == toUser
          ? _value.toUser
          : toUser // ignore: cast_nullable_to_non_nullable
              as String,
      fromUser: null == fromUser
          ? _value.fromUser
          : fromUser // ignore: cast_nullable_to_non_nullable
              as String,
      connectionStatus: null == connectionStatus
          ? _value.connectionStatus
          : connectionStatus // ignore: cast_nullable_to_non_nullable
              as ConnectionStatus,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectionDataImplCopyWith<$Res>
    implements $ConnectionDataCopyWith<$Res> {
  factory _$$ConnectionDataImplCopyWith(_$ConnectionDataImpl value,
          $Res Function(_$ConnectionDataImpl) then) =
      __$$ConnectionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? lastMessage,
      String? acceptTime,
      int key,
      String toUser,
      String fromUser,
      ConnectionStatus connectionStatus,
      @EpochSecondsDateTimeConverter() DateTime? createdAt,
      @EpochSecondsDateTimeConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$ConnectionDataImplCopyWithImpl<$Res>
    extends _$ConnectionDataCopyWithImpl<$Res, _$ConnectionDataImpl>
    implements _$$ConnectionDataImplCopyWith<$Res> {
  __$$ConnectionDataImplCopyWithImpl(
      _$ConnectionDataImpl _value, $Res Function(_$ConnectionDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastMessage = freezed,
    Object? acceptTime = freezed,
    Object? key = null,
    Object? toUser = null,
    Object? fromUser = null,
    Object? connectionStatus = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ConnectionDataImpl(
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as int?,
      acceptTime: freezed == acceptTime
          ? _value.acceptTime
          : acceptTime // ignore: cast_nullable_to_non_nullable
              as String?,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as int,
      toUser: null == toUser
          ? _value.toUser
          : toUser // ignore: cast_nullable_to_non_nullable
              as String,
      fromUser: null == fromUser
          ? _value.fromUser
          : fromUser // ignore: cast_nullable_to_non_nullable
              as String,
      connectionStatus: null == connectionStatus
          ? _value.connectionStatus
          : connectionStatus // ignore: cast_nullable_to_non_nullable
              as ConnectionStatus,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionDataImpl extends _ConnectionData
    with DiagnosticableTreeMixin {
  const _$ConnectionDataImpl(
      {this.lastMessage,
      this.acceptTime,
      required this.key,
      required this.toUser,
      required this.fromUser,
      required this.connectionStatus,
      @EpochSecondsDateTimeConverter() this.createdAt,
      @EpochSecondsDateTimeConverter() this.updatedAt})
      : super._();

  factory _$ConnectionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionDataImplFromJson(json);

  @override
  final int? lastMessage;
  @override
  final String? acceptTime;
  @override
  final int key;
  @override
  final String toUser;
  @override
  final String fromUser;
  @override
  final ConnectionStatus connectionStatus;
  @override
  @EpochSecondsDateTimeConverter()
  final DateTime? createdAt;
  @override
  @EpochSecondsDateTimeConverter()
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConnectionData(lastMessage: $lastMessage, acceptTime: $acceptTime, key: $key, toUser: $toUser, fromUser: $fromUser, connectionStatus: $connectionStatus, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConnectionData'))
      ..add(DiagnosticsProperty('lastMessage', lastMessage))
      ..add(DiagnosticsProperty('acceptTime', acceptTime))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('toUser', toUser))
      ..add(DiagnosticsProperty('fromUser', fromUser))
      ..add(DiagnosticsProperty('connectionStatus', connectionStatus))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionDataImpl &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.acceptTime, acceptTime) ||
                other.acceptTime == acceptTime) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.toUser, toUser) || other.toUser == toUser) &&
            (identical(other.fromUser, fromUser) ||
                other.fromUser == fromUser) &&
            (identical(other.connectionStatus, connectionStatus) ||
                other.connectionStatus == connectionStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lastMessage, acceptTime, key,
      toUser, fromUser, connectionStatus, createdAt, updatedAt);

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionDataImplCopyWith<_$ConnectionDataImpl> get copyWith =>
      __$$ConnectionDataImplCopyWithImpl<_$ConnectionDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionDataImplToJson(
      this,
    );
  }
}

abstract class _ConnectionData extends ConnectionData {
  const factory _ConnectionData(
          {final int? lastMessage,
          final String? acceptTime,
          required final int key,
          required final String toUser,
          required final String fromUser,
          required final ConnectionStatus connectionStatus,
          @EpochSecondsDateTimeConverter() final DateTime? createdAt,
          @EpochSecondsDateTimeConverter() final DateTime? updatedAt}) =
      _$ConnectionDataImpl;
  const _ConnectionData._() : super._();

  factory _ConnectionData.fromJson(Map<String, dynamic> json) =
      _$ConnectionDataImpl.fromJson;

  @override
  int? get lastMessage;
  @override
  String? get acceptTime;
  @override
  int get key;
  @override
  String get toUser;
  @override
  String get fromUser;
  @override
  ConnectionStatus get connectionStatus;
  @override
  @EpochSecondsDateTimeConverter()
  DateTime? get createdAt;
  @override
  @EpochSecondsDateTimeConverter()
  DateTime? get updatedAt;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionDataImplCopyWith<_$ConnectionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
