// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductSummary {

 String get id; String get name; double get price; String? get imageUrl; double? get discountPrice; double? get rating; String get category; bool get hasAiTryOn;
/// Create a copy of ProductSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductSummaryCopyWith<ProductSummary> get copyWith => _$ProductSummaryCopyWithImpl<ProductSummary>(this as ProductSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.category, category) || other.category == category)&&(identical(other.hasAiTryOn, hasAiTryOn) || other.hasAiTryOn == hasAiTryOn));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,price,imageUrl,discountPrice,rating,category,hasAiTryOn);

@override
String toString() {
  return 'ProductSummary(id: $id, name: $name, price: $price, imageUrl: $imageUrl, discountPrice: $discountPrice, rating: $rating, category: $category, hasAiTryOn: $hasAiTryOn)';
}


}

/// @nodoc
abstract mixin class $ProductSummaryCopyWith<$Res>  {
  factory $ProductSummaryCopyWith(ProductSummary value, $Res Function(ProductSummary) _then) = _$ProductSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String name, double price, String? imageUrl, double? discountPrice, double? rating, String category, bool hasAiTryOn
});




}
/// @nodoc
class _$ProductSummaryCopyWithImpl<$Res>
    implements $ProductSummaryCopyWith<$Res> {
  _$ProductSummaryCopyWithImpl(this._self, this._then);

  final ProductSummary _self;
  final $Res Function(ProductSummary) _then;

/// Create a copy of ProductSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? price = null,Object? imageUrl = freezed,Object? discountPrice = freezed,Object? rating = freezed,Object? category = null,Object? hasAiTryOn = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,hasAiTryOn: null == hasAiTryOn ? _self.hasAiTryOn : hasAiTryOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductSummary].
extension ProductSummaryPatterns on ProductSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductSummary value)  $default,){
final _that = this;
switch (_that) {
case _ProductSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ProductSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  double price,  String? imageUrl,  double? discountPrice,  double? rating,  String category,  bool hasAiTryOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductSummary() when $default != null:
return $default(_that.id,_that.name,_that.price,_that.imageUrl,_that.discountPrice,_that.rating,_that.category,_that.hasAiTryOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  double price,  String? imageUrl,  double? discountPrice,  double? rating,  String category,  bool hasAiTryOn)  $default,) {final _that = this;
switch (_that) {
case _ProductSummary():
return $default(_that.id,_that.name,_that.price,_that.imageUrl,_that.discountPrice,_that.rating,_that.category,_that.hasAiTryOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  double price,  String? imageUrl,  double? discountPrice,  double? rating,  String category,  bool hasAiTryOn)?  $default,) {final _that = this;
switch (_that) {
case _ProductSummary() when $default != null:
return $default(_that.id,_that.name,_that.price,_that.imageUrl,_that.discountPrice,_that.rating,_that.category,_that.hasAiTryOn);case _:
  return null;

}
}

}

/// @nodoc


class _ProductSummary implements ProductSummary {
  const _ProductSummary({required this.id, required this.name, required this.price, this.imageUrl, this.discountPrice, this.rating, required this.category, this.hasAiTryOn = false});
  

@override final  String id;
@override final  String name;
@override final  double price;
@override final  String? imageUrl;
@override final  double? discountPrice;
@override final  double? rating;
@override final  String category;
@override@JsonKey() final  bool hasAiTryOn;

/// Create a copy of ProductSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductSummaryCopyWith<_ProductSummary> get copyWith => __$ProductSummaryCopyWithImpl<_ProductSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.category, category) || other.category == category)&&(identical(other.hasAiTryOn, hasAiTryOn) || other.hasAiTryOn == hasAiTryOn));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,price,imageUrl,discountPrice,rating,category,hasAiTryOn);

@override
String toString() {
  return 'ProductSummary(id: $id, name: $name, price: $price, imageUrl: $imageUrl, discountPrice: $discountPrice, rating: $rating, category: $category, hasAiTryOn: $hasAiTryOn)';
}


}

/// @nodoc
abstract mixin class _$ProductSummaryCopyWith<$Res> implements $ProductSummaryCopyWith<$Res> {
  factory _$ProductSummaryCopyWith(_ProductSummary value, $Res Function(_ProductSummary) _then) = __$ProductSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double price, String? imageUrl, double? discountPrice, double? rating, String category, bool hasAiTryOn
});




}
/// @nodoc
class __$ProductSummaryCopyWithImpl<$Res>
    implements _$ProductSummaryCopyWith<$Res> {
  __$ProductSummaryCopyWithImpl(this._self, this._then);

  final _ProductSummary _self;
  final $Res Function(_ProductSummary) _then;

/// Create a copy of ProductSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? price = null,Object? imageUrl = freezed,Object? discountPrice = freezed,Object? rating = freezed,Object? category = null,Object? hasAiTryOn = null,}) {
  return _then(_ProductSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,hasAiTryOn: null == hasAiTryOn ? _self.hasAiTryOn : hasAiTryOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
