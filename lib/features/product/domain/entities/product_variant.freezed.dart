// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_variant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductVariant {

 String get id; String get size; String get color; int get stock; double? get additionalPrice;
/// Create a copy of ProductVariant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductVariantCopyWith<ProductVariant> get copyWith => _$ProductVariantCopyWithImpl<ProductVariant>(this as ProductVariant, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductVariant&&(identical(other.id, id) || other.id == id)&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.additionalPrice, additionalPrice) || other.additionalPrice == additionalPrice));
}


@override
int get hashCode => Object.hash(runtimeType,id,size,color,stock,additionalPrice);

@override
String toString() {
  return 'ProductVariant(id: $id, size: $size, color: $color, stock: $stock, additionalPrice: $additionalPrice)';
}


}

/// @nodoc
abstract mixin class $ProductVariantCopyWith<$Res>  {
  factory $ProductVariantCopyWith(ProductVariant value, $Res Function(ProductVariant) _then) = _$ProductVariantCopyWithImpl;
@useResult
$Res call({
 String id, String size, String color, int stock, double? additionalPrice
});




}
/// @nodoc
class _$ProductVariantCopyWithImpl<$Res>
    implements $ProductVariantCopyWith<$Res> {
  _$ProductVariantCopyWithImpl(this._self, this._then);

  final ProductVariant _self;
  final $Res Function(ProductVariant) _then;

/// Create a copy of ProductVariant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? size = null,Object? color = null,Object? stock = null,Object? additionalPrice = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,additionalPrice: freezed == additionalPrice ? _self.additionalPrice : additionalPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductVariant].
extension ProductVariantPatterns on ProductVariant {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductVariant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductVariant() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductVariant value)  $default,){
final _that = this;
switch (_that) {
case _ProductVariant():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductVariant value)?  $default,){
final _that = this;
switch (_that) {
case _ProductVariant() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String size,  String color,  int stock,  double? additionalPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductVariant() when $default != null:
return $default(_that.id,_that.size,_that.color,_that.stock,_that.additionalPrice);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String size,  String color,  int stock,  double? additionalPrice)  $default,) {final _that = this;
switch (_that) {
case _ProductVariant():
return $default(_that.id,_that.size,_that.color,_that.stock,_that.additionalPrice);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String size,  String color,  int stock,  double? additionalPrice)?  $default,) {final _that = this;
switch (_that) {
case _ProductVariant() when $default != null:
return $default(_that.id,_that.size,_that.color,_that.stock,_that.additionalPrice);case _:
  return null;

}
}

}

/// @nodoc


class _ProductVariant implements ProductVariant {
  const _ProductVariant({required this.id, required this.size, required this.color, required this.stock, this.additionalPrice});
  

@override final  String id;
@override final  String size;
@override final  String color;
@override final  int stock;
@override final  double? additionalPrice;

/// Create a copy of ProductVariant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductVariantCopyWith<_ProductVariant> get copyWith => __$ProductVariantCopyWithImpl<_ProductVariant>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductVariant&&(identical(other.id, id) || other.id == id)&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.additionalPrice, additionalPrice) || other.additionalPrice == additionalPrice));
}


@override
int get hashCode => Object.hash(runtimeType,id,size,color,stock,additionalPrice);

@override
String toString() {
  return 'ProductVariant(id: $id, size: $size, color: $color, stock: $stock, additionalPrice: $additionalPrice)';
}


}

/// @nodoc
abstract mixin class _$ProductVariantCopyWith<$Res> implements $ProductVariantCopyWith<$Res> {
  factory _$ProductVariantCopyWith(_ProductVariant value, $Res Function(_ProductVariant) _then) = __$ProductVariantCopyWithImpl;
@override @useResult
$Res call({
 String id, String size, String color, int stock, double? additionalPrice
});




}
/// @nodoc
class __$ProductVariantCopyWithImpl<$Res>
    implements _$ProductVariantCopyWith<$Res> {
  __$ProductVariantCopyWithImpl(this._self, this._then);

  final _ProductVariant _self;
  final $Res Function(_ProductVariant) _then;

/// Create a copy of ProductVariant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? size = null,Object? color = null,Object? stock = null,Object? additionalPrice = freezed,}) {
  return _then(_ProductVariant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,additionalPrice: freezed == additionalPrice ? _self.additionalPrice : additionalPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
