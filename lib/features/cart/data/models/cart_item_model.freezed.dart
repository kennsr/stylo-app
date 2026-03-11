// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartItemModel {

 String get id;@JsonKey(name: 'product_id') String get productId;@JsonKey(name: 'product_name') String get productName;@JsonKey(name: 'product_image') String get productImage; double get price; int get quantity; String get size; String get color;@JsonKey(name: 'discount_price') double? get discountPrice;
/// Create a copy of CartItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemModelCopyWith<CartItemModel> get copyWith => _$CartItemModelCopyWithImpl<CartItemModel>(this as CartItemModel, _$identity);

  /// Serializes this CartItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productImage, productImage) || other.productImage == productImage)&&(identical(other.price, price) || other.price == price)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,productName,productImage,price,quantity,size,color,discountPrice);

@override
String toString() {
  return 'CartItemModel(id: $id, productId: $productId, productName: $productName, productImage: $productImage, price: $price, quantity: $quantity, size: $size, color: $color, discountPrice: $discountPrice)';
}


}

/// @nodoc
abstract mixin class $CartItemModelCopyWith<$Res>  {
  factory $CartItemModelCopyWith(CartItemModel value, $Res Function(CartItemModel) _then) = _$CartItemModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'product_id') String productId,@JsonKey(name: 'product_name') String productName,@JsonKey(name: 'product_image') String productImage, double price, int quantity, String size, String color,@JsonKey(name: 'discount_price') double? discountPrice
});




}
/// @nodoc
class _$CartItemModelCopyWithImpl<$Res>
    implements $CartItemModelCopyWith<$Res> {
  _$CartItemModelCopyWithImpl(this._self, this._then);

  final CartItemModel _self;
  final $Res Function(CartItemModel) _then;

/// Create a copy of CartItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? productName = null,Object? productImage = null,Object? price = null,Object? quantity = null,Object? size = null,Object? color = null,Object? discountPrice = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productImage: null == productImage ? _self.productImage : productImage // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartItemModel].
extension CartItemModelPatterns on CartItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItemModel value)  $default,){
final _that = this;
switch (_that) {
case _CartItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _CartItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'product_id')  String productId, @JsonKey(name: 'product_name')  String productName, @JsonKey(name: 'product_image')  String productImage,  double price,  int quantity,  String size,  String color, @JsonKey(name: 'discount_price')  double? discountPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartItemModel() when $default != null:
return $default(_that.id,_that.productId,_that.productName,_that.productImage,_that.price,_that.quantity,_that.size,_that.color,_that.discountPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'product_id')  String productId, @JsonKey(name: 'product_name')  String productName, @JsonKey(name: 'product_image')  String productImage,  double price,  int quantity,  String size,  String color, @JsonKey(name: 'discount_price')  double? discountPrice)  $default,) {final _that = this;
switch (_that) {
case _CartItemModel():
return $default(_that.id,_that.productId,_that.productName,_that.productImage,_that.price,_that.quantity,_that.size,_that.color,_that.discountPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'product_id')  String productId, @JsonKey(name: 'product_name')  String productName, @JsonKey(name: 'product_image')  String productImage,  double price,  int quantity,  String size,  String color, @JsonKey(name: 'discount_price')  double? discountPrice)?  $default,) {final _that = this;
switch (_that) {
case _CartItemModel() when $default != null:
return $default(_that.id,_that.productId,_that.productName,_that.productImage,_that.price,_that.quantity,_that.size,_that.color,_that.discountPrice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartItemModel implements CartItemModel {
  const _CartItemModel({required this.id, @JsonKey(name: 'product_id') required this.productId, @JsonKey(name: 'product_name') required this.productName, @JsonKey(name: 'product_image') required this.productImage, required this.price, required this.quantity, required this.size, required this.color, @JsonKey(name: 'discount_price') this.discountPrice});
  factory _CartItemModel.fromJson(Map<String, dynamic> json) => _$CartItemModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'product_id') final  String productId;
@override@JsonKey(name: 'product_name') final  String productName;
@override@JsonKey(name: 'product_image') final  String productImage;
@override final  double price;
@override final  int quantity;
@override final  String size;
@override final  String color;
@override@JsonKey(name: 'discount_price') final  double? discountPrice;

/// Create a copy of CartItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemModelCopyWith<_CartItemModel> get copyWith => __$CartItemModelCopyWithImpl<_CartItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productImage, productImage) || other.productImage == productImage)&&(identical(other.price, price) || other.price == price)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,productName,productImage,price,quantity,size,color,discountPrice);

@override
String toString() {
  return 'CartItemModel(id: $id, productId: $productId, productName: $productName, productImage: $productImage, price: $price, quantity: $quantity, size: $size, color: $color, discountPrice: $discountPrice)';
}


}

/// @nodoc
abstract mixin class _$CartItemModelCopyWith<$Res> implements $CartItemModelCopyWith<$Res> {
  factory _$CartItemModelCopyWith(_CartItemModel value, $Res Function(_CartItemModel) _then) = __$CartItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'product_id') String productId,@JsonKey(name: 'product_name') String productName,@JsonKey(name: 'product_image') String productImage, double price, int quantity, String size, String color,@JsonKey(name: 'discount_price') double? discountPrice
});




}
/// @nodoc
class __$CartItemModelCopyWithImpl<$Res>
    implements _$CartItemModelCopyWith<$Res> {
  __$CartItemModelCopyWithImpl(this._self, this._then);

  final _CartItemModel _self;
  final $Res Function(_CartItemModel) _then;

/// Create a copy of CartItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? productName = null,Object? productImage = null,Object? price = null,Object? quantity = null,Object? size = null,Object? color = null,Object? discountPrice = freezed,}) {
  return _then(_CartItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productImage: null == productImage ? _self.productImage : productImage // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
