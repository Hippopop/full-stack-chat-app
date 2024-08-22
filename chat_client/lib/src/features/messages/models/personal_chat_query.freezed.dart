// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_chat_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PersonalChatQuery _$PersonalChatQueryFromJson(Map<String, dynamic> json) {
  return _PersonalChatQuery.fromJson(json);
}

/// @nodoc
mixin _$PersonalChatQuery {
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  String? get birthdate => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get activityStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PersonalChatQueryCopyWith<PersonalChatQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalChatQueryCopyWith<$Res> {
  factory $PersonalChatQueryCopyWith(
          PersonalChatQuery value, $Res Function(PersonalChatQuery) then) =
      _$PersonalChatQueryCopyWithImpl<$Res, PersonalChatQuery>;
  @useResult
  $Res call(
      {String? email,
      String? phone,
      String? name,
      String? photo,
      String? birthdate,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? activityStatus});
}

/// @nodoc
class _$PersonalChatQueryCopyWithImpl<$Res, $Val extends PersonalChatQuery>
    implements $PersonalChatQueryCopyWith<$Res> {
  _$PersonalChatQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? phone = freezed,
    Object? name = freezed,
    Object? photo = freezed,
    Object? birthdate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? activityStatus = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      activityStatus: freezed == activityStatus
          ? _value.activityStatus
          : activityStatus // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonalChatQueryImplCopyWith<$Res>
    implements $PersonalChatQueryCopyWith<$Res> {
  factory _$$PersonalChatQueryImplCopyWith(_$PersonalChatQueryImpl value,
          $Res Function(_$PersonalChatQueryImpl) then) =
      __$$PersonalChatQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? email,
      String? phone,
      String? name,
      String? photo,
      String? birthdate,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? activityStatus});
}

/// @nodoc
class __$$PersonalChatQueryImplCopyWithImpl<$Res>
    extends _$PersonalChatQueryCopyWithImpl<$Res, _$PersonalChatQueryImpl>
    implements _$$PersonalChatQueryImplCopyWith<$Res> {
  __$$PersonalChatQueryImplCopyWithImpl(_$PersonalChatQueryImpl _value,
      $Res Function(_$PersonalChatQueryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? phone = freezed,
    Object? name = freezed,
    Object? photo = freezed,
    Object? birthdate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? activityStatus = freezed,
  }) {
    return _then(_$PersonalChatQueryImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      activityStatus: freezed == activityStatus
          ? _value.activityStatus
          : activityStatus // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalChatQueryImpl extends _PersonalChatQuery
    with DiagnosticableTreeMixin {
  const _$PersonalChatQueryImpl(
      {this.email,
      this.phone,
      this.name,
      this.photo,
      this.birthdate,
      this.createdAt,
      this.updatedAt,
      this.activityStatus})
      : super._();

  factory _$PersonalChatQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalChatQueryImplFromJson(json);

  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? name;
  @override
  final String? photo;
  @override
  final String? birthdate;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? activityStatus;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PersonalChatQuery(email: $email, phone: $phone, name: $name, photo: $photo, birthdate: $birthdate, createdAt: $createdAt, updatedAt: $updatedAt, activityStatus: $activityStatus)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PersonalChatQuery'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('photo', photo))
      ..add(DiagnosticsProperty('birthdate', birthdate))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('activityStatus', activityStatus));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalChatQueryImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.activityStatus, activityStatus) ||
                other.activityStatus == activityStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, phone, name, photo,
      birthdate, createdAt, updatedAt, activityStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalChatQueryImplCopyWith<_$PersonalChatQueryImpl> get copyWith =>
      __$$PersonalChatQueryImplCopyWithImpl<_$PersonalChatQueryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalChatQueryImplToJson(
      this,
    );
  }
}

abstract class _PersonalChatQuery extends PersonalChatQuery {
  const factory _PersonalChatQuery(
      {final String? email,
      final String? phone,
      final String? name,
      final String? photo,
      final String? birthdate,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? activityStatus}) = _$PersonalChatQueryImpl;
  const _PersonalChatQuery._() : super._();

  factory _PersonalChatQuery.fromJson(Map<String, dynamic> json) =
      _$PersonalChatQueryImpl.fromJson;

  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get name;
  @override
  String? get photo;
  @override
  String? get birthdate;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get activityStatus;
  @override
  @JsonKey(ignore: true)
  _$$PersonalChatQueryImplCopyWith<_$PersonalChatQueryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
