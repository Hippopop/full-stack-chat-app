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
  String? get name => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PersonalChatQuery to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PersonalChatQuery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonalChatQueryCopyWith<PersonalChatQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalChatQueryCopyWith<$Res> {
  factory $PersonalChatQueryCopyWith(
          PersonalChatQuery value, $Res Function(PersonalChatQuery) then) =
      _$PersonalChatQueryCopyWithImpl<$Res, PersonalChatQuery>;
  @useResult
  $Res call({String? name, String? photo, bool? isActive, DateTime? updatedAt});
}

/// @nodoc
class _$PersonalChatQueryCopyWithImpl<$Res, $Val extends PersonalChatQuery>
    implements $PersonalChatQueryCopyWith<$Res> {
  _$PersonalChatQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonalChatQuery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? photo = freezed,
    Object? isActive = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
  $Res call({String? name, String? photo, bool? isActive, DateTime? updatedAt});
}

/// @nodoc
class __$$PersonalChatQueryImplCopyWithImpl<$Res>
    extends _$PersonalChatQueryCopyWithImpl<$Res, _$PersonalChatQueryImpl>
    implements _$$PersonalChatQueryImplCopyWith<$Res> {
  __$$PersonalChatQueryImplCopyWithImpl(_$PersonalChatQueryImpl _value,
      $Res Function(_$PersonalChatQueryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PersonalChatQuery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? photo = freezed,
    Object? isActive = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$PersonalChatQueryImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalChatQueryImpl extends _PersonalChatQuery
    with DiagnosticableTreeMixin {
  const _$PersonalChatQueryImpl(
      {this.name, this.photo, this.isActive, this.updatedAt})
      : super._();

  factory _$PersonalChatQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalChatQueryImplFromJson(json);

  @override
  final String? name;
  @override
  final String? photo;
  @override
  final bool? isActive;
  @override
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PersonalChatQuery(name: $name, photo: $photo, isActive: $isActive, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PersonalChatQuery'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('photo', photo))
      ..add(DiagnosticsProperty('isActive', isActive))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalChatQueryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, photo, isActive, updatedAt);

  /// Create a copy of PersonalChatQuery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {final String? name,
      final String? photo,
      final bool? isActive,
      final DateTime? updatedAt}) = _$PersonalChatQueryImpl;
  const _PersonalChatQuery._() : super._();

  factory _PersonalChatQuery.fromJson(Map<String, dynamic> json) =
      _$PersonalChatQueryImpl.fromJson;

  @override
  String? get name;
  @override
  String? get photo;
  @override
  bool? get isActive;
  @override
  DateTime? get updatedAt;

  /// Create a copy of PersonalChatQuery
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonalChatQueryImplCopyWith<_$PersonalChatQueryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
