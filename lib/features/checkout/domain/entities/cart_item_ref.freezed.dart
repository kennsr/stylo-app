// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_item_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartItemRef {

 String get productId; String get productName; int get quantity; double get price; String get size; String get color; String? get productImage;
/// Create a copy of CartItemRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemRefCopyWith<CartItemRef> get copyWith => _$CartItemRefCopyWithImpl<CartItemRef>(this as CartItemRef, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemRef&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.productImage, productImage) || other.productImage == productImage));
}


@override
int get hashCode => Object.hash(runtimeType,productId,productName,quantity,price,size,color,productImage);

@override
String toString() {
  return 'CartItemRef(productId: $productId, productName: $productName, quantity: $quantity, price: $price, size: $size, color: $color, productImage: $productImage)';
}


}

/// @nodoc
abstract mixin class $CartItemRefCopyWith<$Res>  {
  factory $CartItemRefCopyWith(CartItemRef value, $Res Function(CartItemRef) _then) = _$CartItemRefCopyWithImpl;
@useResult
$Res call({
 String productId, String productName, int quantity, double price, String size, String color, String? productImage
});




}
/// @nodoc
class _$CartItemRefCopyWithImpl<$Res>
    implements $CartItemRefCopyWith<$Res> {
  _$CartItemRefCopyWithImpl(this._self, this._then);

  final CartItemRef _self;
  final $Res Function(CartItemRef) _then;

/// Create a copy of CartItemRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? productName = null,Object? quantity = null,Object? price = null,Object? size = null,Object? color = null,Object? productImage = freezed,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,productImage: freezed == productImage ? _self.productImage : productImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartItemRef].
extension CartItemRefPatterns on CartItemRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItemRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItemRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItemRef value)  $default,){
final _that = this;
switch (_that) {
case _CartItemRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItemRef value)?  $default,){
final _that = this;
switch (_that) {
case _CartItemRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  String productName,  int quantity,  double price,  String size,  String color,  String? productImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartItemRef() when $default != null:
return $default(_that.productId,_that.productName,_that.quantity,_that.price,_that.size,_that.color,_that.productImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  String productName,  int quantity,  double price,  String size,  String color,  String? productImage)  $default,) {final _that = this;
switch (_that) {
case _CartItemRef():
return $default(_that.productId,_that.productName,_that.quantity,_that.price,_that.size,_that.color,_that.productImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  String productName,  int quantity,  double price,  String size,  String color,  String? productImage)?  $default,) {final _that = this;
switch (_that) {
case _CartItemRef() when $default != null:
return $default(_that.productId,_that.productName,_that.quantity,_that.price,_that.size,_that.color,_that.productImage);case _:
  return null;

}
}

}

/// @nodoc


class _CartItemRef implements CartItemRef {
  const _CartItemRef({required this.productId, required this.productName, required this.quantity, required this.price, required this.size, required this.color, this.productImage});
  

@override final  String productId;
@override final  String productName;
@override final  int quantity;
@override final  double price;
@override final  String size;
@override final  String color;
@override final  String? productImage;

/// Create a copy of CartItemRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemRefCopyWith<_CartItemRef> get copyWith => __$CartItemRefCopyWithImpl<_CartItemRef>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItemRef&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.productImage, productImage) || other.productImage == productImage));
}


@override
int get hashCode => Object.hash(runtimeType,productId,productName,quantity,price,size,color,productImage);

@override
String toString() {
  return 'CartItemRef(productId: $productId, productName: $productName, quantity: $quantity, price: $price, size: $size, color: $color, productImage: $productImage)';
}


}

/// @nodoc
abstract mixin class _$CartItemRefCopyWith<$Res> implements $CartItemRefCopyWith<$Res> {
  factory _$CartItemRefCopyWith(_CartItemRef value, $Res Function(_CartItemRef) _then) = __$CartItemRefCopyWithImpl;
@override @useResult
$Res call({
 String productId, String productName, int quantity, double price, String size, String color, String? productImage
});




}
/// @nodoc
class __$CartItemRefCopyWithImpl<$Res>
    implements _$CartItemRefCopyWith<$Res> {
  __$CartItemRefCopyWithImpl(this._self, this._then);

  final _CartItemRef _self;
  final $Res Function(_CartItemRef) _then;

/// Create a copy of CartItemRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? productName = null,Object? quantity = null,Object? price = null,Object? size = null,Object? color = null,Object? productImage = freezed,}) {
  return _then(_CartItemRef(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,productImage: freezed == productImage ? _self.productImage : productImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
