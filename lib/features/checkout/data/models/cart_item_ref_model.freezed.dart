// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_item_ref_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartItemRefModel {

@JsonKey(name: 'product_id') String get productId;@JsonKey(name: 'product_name') String get productName; int get quantity; double get price; String get size; String get color;@JsonKey(name: 'product_image') String? get productImage;
/// Create a copy of CartItemRefModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemRefModelCopyWith<CartItemRefModel> get copyWith => _$CartItemRefModelCopyWithImpl<CartItemRefModel>(this as CartItemRefModel, _$identity);

  /// Serializes this CartItemRefModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemRefModel&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.productImage, productImage) || other.productImage == productImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,productName,quantity,price,size,color,productImage);

@override
String toString() {
  return 'CartItemRefModel(productId: $productId, productName: $productName, quantity: $quantity, price: $price, size: $size, color: $color, productImage: $productImage)';
}


}

/// @nodoc
abstract mixin class $CartItemRefModelCopyWith<$Res>  {
  factory $CartItemRefModelCopyWith(CartItemRefModel value, $Res Function(CartItemRefModel) _then) = _$CartItemRefModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'product_id') String productId,@JsonKey(name: 'product_name') String productName, int quantity, double price, String size, String color,@JsonKey(name: 'product_image') String? productImage
});




}
/// @nodoc
class _$CartItemRefModelCopyWithImpl<$Res>
    implements $CartItemRefModelCopyWith<$Res> {
  _$CartItemRefModelCopyWithImpl(this._self, this._then);

  final CartItemRefModel _self;
  final $Res Function(CartItemRefModel) _then;

/// Create a copy of CartItemRefModel
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


/// Adds pattern-matching-related methods to [CartItemRefModel].
extension CartItemRefModelPatterns on CartItemRefModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItemRefModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItemRefModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItemRefModel value)  $default,){
final _that = this;
switch (_that) {
case _CartItemRefModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItemRefModel value)?  $default,){
final _that = this;
switch (_that) {
case _CartItemRefModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_id')  String productId, @JsonKey(name: 'product_name')  String productName,  int quantity,  double price,  String size,  String color, @JsonKey(name: 'product_image')  String? productImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartItemRefModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_id')  String productId, @JsonKey(name: 'product_name')  String productName,  int quantity,  double price,  String size,  String color, @JsonKey(name: 'product_image')  String? productImage)  $default,) {final _that = this;
switch (_that) {
case _CartItemRefModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'product_id')  String productId, @JsonKey(name: 'product_name')  String productName,  int quantity,  double price,  String size,  String color, @JsonKey(name: 'product_image')  String? productImage)?  $default,) {final _that = this;
switch (_that) {
case _CartItemRefModel() when $default != null:
return $default(_that.productId,_that.productName,_that.quantity,_that.price,_that.size,_that.color,_that.productImage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartItemRefModel implements CartItemRefModel {
  const _CartItemRefModel({@JsonKey(name: 'product_id') required this.productId, @JsonKey(name: 'product_name') required this.productName, required this.quantity, required this.price, required this.size, required this.color, @JsonKey(name: 'product_image') this.productImage});
  factory _CartItemRefModel.fromJson(Map<String, dynamic> json) => _$CartItemRefModelFromJson(json);

@override@JsonKey(name: 'product_id') final  String productId;
@override@JsonKey(name: 'product_name') final  String productName;
@override final  int quantity;
@override final  double price;
@override final  String size;
@override final  String color;
@override@JsonKey(name: 'product_image') final  String? productImage;

/// Create a copy of CartItemRefModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemRefModelCopyWith<_CartItemRefModel> get copyWith => __$CartItemRefModelCopyWithImpl<_CartItemRefModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartItemRefModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItemRefModel&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.productImage, productImage) || other.productImage == productImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,productName,quantity,price,size,color,productImage);

@override
String toString() {
  return 'CartItemRefModel(productId: $productId, productName: $productName, quantity: $quantity, price: $price, size: $size, color: $color, productImage: $productImage)';
}


}

/// @nodoc
abstract mixin class _$CartItemRefModelCopyWith<$Res> implements $CartItemRefModelCopyWith<$Res> {
  factory _$CartItemRefModelCopyWith(_CartItemRefModel value, $Res Function(_CartItemRefModel) _then) = __$CartItemRefModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'product_id') String productId,@JsonKey(name: 'product_name') String productName, int quantity, double price, String size, String color,@JsonKey(name: 'product_image') String? productImage
});




}
/// @nodoc
class __$CartItemRefModelCopyWithImpl<$Res>
    implements _$CartItemRefModelCopyWith<$Res> {
  __$CartItemRefModelCopyWithImpl(this._self, this._then);

  final _CartItemRefModel _self;
  final $Res Function(_CartItemRefModel) _then;

/// Create a copy of CartItemRefModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? productName = null,Object? quantity = null,Object? price = null,Object? size = null,Object? color = null,Object? productImage = freezed,}) {
  return _then(_CartItemRefModel(
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
