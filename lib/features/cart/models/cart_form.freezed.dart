// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CartForm _$CartFormFromJson(Map<String, dynamic> json) {
  return _CartForm.fromJson(json);
}

/// @nodoc
mixin _$CartForm {
  @JsonKey(name: "product_id")
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  /// Serializes this CartForm to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CartForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartFormCopyWith<CartForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartFormCopyWith<$Res> {
  factory $CartFormCopyWith(CartForm value, $Res Function(CartForm) then) =
      _$CartFormCopyWithImpl<$Res, CartForm>;
  @useResult
  $Res call({@JsonKey(name: "product_id") String productId, int quantity});
}

/// @nodoc
class _$CartFormCopyWithImpl<$Res, $Val extends CartForm>
    implements $CartFormCopyWith<$Res> {
  _$CartFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartFormImplCopyWith<$Res>
    implements $CartFormCopyWith<$Res> {
  factory _$$CartFormImplCopyWith(
          _$CartFormImpl value, $Res Function(_$CartFormImpl) then) =
      __$$CartFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "product_id") String productId, int quantity});
}

/// @nodoc
class __$$CartFormImplCopyWithImpl<$Res>
    extends _$CartFormCopyWithImpl<$Res, _$CartFormImpl>
    implements _$$CartFormImplCopyWith<$Res> {
  __$$CartFormImplCopyWithImpl(
      _$CartFormImpl _value, $Res Function(_$CartFormImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
  }) {
    return _then(_$CartFormImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CartFormImpl implements _CartForm {
  const _$CartFormImpl(
      {@JsonKey(name: "product_id") required this.productId,
      required this.quantity});

  factory _$CartFormImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartFormImplFromJson(json);

  @override
  @JsonKey(name: "product_id")
  final String productId;
  @override
  final int quantity;

  @override
  String toString() {
    return 'CartForm(productId: $productId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartFormImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, productId, quantity);

  /// Create a copy of CartForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartFormImplCopyWith<_$CartFormImpl> get copyWith =>
      __$$CartFormImplCopyWithImpl<_$CartFormImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartFormImplToJson(
      this,
    );
  }
}

abstract class _CartForm implements CartForm {
  const factory _CartForm(
      {@JsonKey(name: "product_id") required final String productId,
      required final int quantity}) = _$CartFormImpl;

  factory _CartForm.fromJson(Map<String, dynamic> json) =
      _$CartFormImpl.fromJson;

  @override
  @JsonKey(name: "product_id")
  String get productId;
  @override
  int get quantity;

  /// Create a copy of CartForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartFormImplCopyWith<_$CartFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
