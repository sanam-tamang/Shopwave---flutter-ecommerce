// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocalUserModel _$LocalUserModelFromJson(Map<String, dynamic> json) {
  return _LocalUserModel.fromJson(json);
}

/// @nodoc
mixin _$LocalUserModel {
  String get userId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;

  /// Serializes this LocalUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocalUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalUserModelCopyWith<LocalUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalUserModelCopyWith<$Res> {
  factory $LocalUserModelCopyWith(
          LocalUserModel value, $Res Function(LocalUserModel) then) =
      _$LocalUserModelCopyWithImpl<$Res, LocalUserModel>;
  @useResult
  $Res call({String userId, String role});
}

/// @nodoc
class _$LocalUserModelCopyWithImpl<$Res, $Val extends LocalUserModel>
    implements $LocalUserModelCopyWith<$Res> {
  _$LocalUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? role = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalUserModelImplCopyWith<$Res>
    implements $LocalUserModelCopyWith<$Res> {
  factory _$$LocalUserModelImplCopyWith(_$LocalUserModelImpl value,
          $Res Function(_$LocalUserModelImpl) then) =
      __$$LocalUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String role});
}

/// @nodoc
class __$$LocalUserModelImplCopyWithImpl<$Res>
    extends _$LocalUserModelCopyWithImpl<$Res, _$LocalUserModelImpl>
    implements _$$LocalUserModelImplCopyWith<$Res> {
  __$$LocalUserModelImplCopyWithImpl(
      _$LocalUserModelImpl _value, $Res Function(_$LocalUserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocalUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? role = null,
  }) {
    return _then(_$LocalUserModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalUserModelImpl implements _LocalUserModel {
  const _$LocalUserModelImpl({required this.userId, required this.role});

  factory _$LocalUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalUserModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String role;

  @override
  String toString() {
    return 'LocalUserModel(userId: $userId, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalUserModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, role);

  /// Create a copy of LocalUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalUserModelImplCopyWith<_$LocalUserModelImpl> get copyWith =>
      __$$LocalUserModelImplCopyWithImpl<_$LocalUserModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalUserModelImplToJson(
      this,
    );
  }
}

abstract class _LocalUserModel implements LocalUserModel {
  const factory _LocalUserModel(
      {required final String userId,
      required final String role}) = _$LocalUserModelImpl;

  factory _LocalUserModel.fromJson(Map<String, dynamic> json) =
      _$LocalUserModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get role;

  /// Create a copy of LocalUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalUserModelImplCopyWith<_$LocalUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
