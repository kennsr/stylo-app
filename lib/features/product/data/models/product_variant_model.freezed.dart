// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_variant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductVariantModel {

 String get id; String get size; String get color; int get stock;@JsonKey(name: 'additional_price') double? get additionalPrice;
/// Create a copy of ProductVariantModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductVariantModelCopyWith<ProductVariantModel> get copyWith => _$ProductVariantModelCopyWithImpl<ProductVariantModel>(this as ProductVariantModel, _$identity);

  /// Serializes this ProductVariantModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductVariantModel&&(identical(other.id, id) || other.id == id)&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.additionalPrice, additionalPrice) || other.additionalPrice == additionalPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,size,color,stock,additionalPrice);

@override
String toString() {
  return 'ProductVariantModel(id: $id, size: $size, color: $color, stock: $stock, additionalPrice: $additionalPrice)';
}


}

/// @nodoc
abstract mixin class $ProductVariantModelCopyWith<$Res>  {
  factory $ProductVariantModelCopyWith(ProductVariantModel value, $Res Function(ProductVariantModel) _then) = _$ProductVariantModelCopyWithImpl;
@useResult
$Res call({
 String id, String size, String color, int stock,@JsonKey(name: 'additional_price') double? additionalPrice
});




}
/// @nodoc
class _$ProductVariantModelCopyWithImpl<$Res>
    implements $ProductVariantModelCopyWith<$Res> {
  _$ProductVariantModelCopyWithImpl(this._self, this._then);

  final ProductVariantModel _self;
  final $Res Function(ProductVariantModel) _then;

/// Create a copy of ProductVariantModel
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


/// Adds pattern-matching-related methods to [ProductVariantModel].
extension ProductVariantModelPatterns on ProductVariantModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductVariantModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductVariantModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductVariantModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductVariantModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductVariantModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductVariantModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String size,  String color,  int stock, @JsonKey(name: 'additional_price')  double? additionalPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductVariantModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String size,  String color,  int stock, @JsonKey(name: 'additional_price')  double? additionalPrice)  $default,) {final _that = this;
switch (_that) {
case _ProductVariantModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String size,  String color,  int stock, @JsonKey(name: 'additional_price')  double? additionalPrice)?  $default,) {final _that = this;
switch (_that) {
case _ProductVariantModel() when $default != null:
return $default(_that.id,_that.size,_that.color,_that.stock,_that.additionalPrice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductVariantModel implements ProductVariantModel {
  const _ProductVariantModel({required this.id, required this.size, required this.color, required this.stock, @JsonKey(name: 'additional_price') this.additionalPrice});
  factory _ProductVariantModel.fromJson(Map<String, dynamic> json) => _$ProductVariantModelFromJson(json);

@override final  String id;
@override final  String size;
@override final  String color;
@override final  int stock;
@override@JsonKey(name: 'additional_price') final  double? additionalPrice;

/// Create a copy of ProductVariantModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductVariantModelCopyWith<_ProductVariantModel> get copyWith => __$ProductVariantModelCopyWithImpl<_ProductVariantModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductVariantModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductVariantModel&&(identical(other.id, id) || other.id == id)&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.additionalPrice, additionalPrice) || other.additionalPrice == additionalPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,size,color,stock,additionalPrice);

@override
String toString() {
  return 'ProductVariantModel(id: $id, size: $size, color: $color, stock: $stock, additionalPrice: $additionalPrice)';
}


}

/// @nodoc
abstract mixin class _$ProductVariantModelCopyWith<$Res> implements $ProductVariantModelCopyWith<$Res> {
  factory _$ProductVariantModelCopyWith(_ProductVariantModel value, $Res Function(_ProductVariantModel) _then) = __$ProductVariantModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String size, String color, int stock,@JsonKey(name: 'additional_price') double? additionalPrice
});




}
/// @nodoc
class __$ProductVariantModelCopyWithImpl<$Res>
    implements _$ProductVariantModelCopyWith<$Res> {
  __$ProductVariantModelCopyWithImpl(this._self, this._then);

  final _ProductVariantModel _self;
  final $Res Function(_ProductVariantModel) _then;

/// Create a copy of ProductVariantModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? size = null,Object? color = null,Object? stock = null,Object? additionalPrice = freezed,}) {
  return _then(_ProductVariantModel(
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
