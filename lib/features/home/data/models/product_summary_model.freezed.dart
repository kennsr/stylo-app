// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductSummaryModel {

 String get id; String get name; double get price;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'discount_price') double? get discountPrice; double? get rating; String get category;@JsonKey(name: 'has_ai_try_on') bool get hasAiTryOn;
/// Create a copy of ProductSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductSummaryModelCopyWith<ProductSummaryModel> get copyWith => _$ProductSummaryModelCopyWithImpl<ProductSummaryModel>(this as ProductSummaryModel, _$identity);

  /// Serializes this ProductSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.category, category) || other.category == category)&&(identical(other.hasAiTryOn, hasAiTryOn) || other.hasAiTryOn == hasAiTryOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,price,imageUrl,discountPrice,rating,category,hasAiTryOn);

@override
String toString() {
  return 'ProductSummaryModel(id: $id, name: $name, price: $price, imageUrl: $imageUrl, discountPrice: $discountPrice, rating: $rating, category: $category, hasAiTryOn: $hasAiTryOn)';
}


}

/// @nodoc
abstract mixin class $ProductSummaryModelCopyWith<$Res>  {
  factory $ProductSummaryModelCopyWith(ProductSummaryModel value, $Res Function(ProductSummaryModel) _then) = _$ProductSummaryModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, double price,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'discount_price') double? discountPrice, double? rating, String category,@JsonKey(name: 'has_ai_try_on') bool hasAiTryOn
});




}
/// @nodoc
class _$ProductSummaryModelCopyWithImpl<$Res>
    implements $ProductSummaryModelCopyWith<$Res> {
  _$ProductSummaryModelCopyWithImpl(this._self, this._then);

  final ProductSummaryModel _self;
  final $Res Function(ProductSummaryModel) _then;

/// Create a copy of ProductSummaryModel
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


/// Adds pattern-matching-related methods to [ProductSummaryModel].
extension ProductSummaryModelPatterns on ProductSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  double price, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'discount_price')  double? discountPrice,  double? rating,  String category, @JsonKey(name: 'has_ai_try_on')  bool hasAiTryOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductSummaryModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  double price, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'discount_price')  double? discountPrice,  double? rating,  String category, @JsonKey(name: 'has_ai_try_on')  bool hasAiTryOn)  $default,) {final _that = this;
switch (_that) {
case _ProductSummaryModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  double price, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'discount_price')  double? discountPrice,  double? rating,  String category, @JsonKey(name: 'has_ai_try_on')  bool hasAiTryOn)?  $default,) {final _that = this;
switch (_that) {
case _ProductSummaryModel() when $default != null:
return $default(_that.id,_that.name,_that.price,_that.imageUrl,_that.discountPrice,_that.rating,_that.category,_that.hasAiTryOn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductSummaryModel extends ProductSummaryModel {
  const _ProductSummaryModel({required this.id, required this.name, required this.price, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'discount_price') this.discountPrice, this.rating, required this.category, @JsonKey(name: 'has_ai_try_on') this.hasAiTryOn = false}): super._();
  factory _ProductSummaryModel.fromJson(Map<String, dynamic> json) => _$ProductSummaryModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  double price;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'discount_price') final  double? discountPrice;
@override final  double? rating;
@override final  String category;
@override@JsonKey(name: 'has_ai_try_on') final  bool hasAiTryOn;

/// Create a copy of ProductSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductSummaryModelCopyWith<_ProductSummaryModel> get copyWith => __$ProductSummaryModelCopyWithImpl<_ProductSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.category, category) || other.category == category)&&(identical(other.hasAiTryOn, hasAiTryOn) || other.hasAiTryOn == hasAiTryOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,price,imageUrl,discountPrice,rating,category,hasAiTryOn);

@override
String toString() {
  return 'ProductSummaryModel(id: $id, name: $name, price: $price, imageUrl: $imageUrl, discountPrice: $discountPrice, rating: $rating, category: $category, hasAiTryOn: $hasAiTryOn)';
}


}

/// @nodoc
abstract mixin class _$ProductSummaryModelCopyWith<$Res> implements $ProductSummaryModelCopyWith<$Res> {
  factory _$ProductSummaryModelCopyWith(_ProductSummaryModel value, $Res Function(_ProductSummaryModel) _then) = __$ProductSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double price,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'discount_price') double? discountPrice, double? rating, String category,@JsonKey(name: 'has_ai_try_on') bool hasAiTryOn
});




}
/// @nodoc
class __$ProductSummaryModelCopyWithImpl<$Res>
    implements _$ProductSummaryModelCopyWith<$Res> {
  __$ProductSummaryModelCopyWithImpl(this._self, this._then);

  final _ProductSummaryModel _self;
  final $Res Function(_ProductSummaryModel) _then;

/// Create a copy of ProductSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? price = null,Object? imageUrl = freezed,Object? discountPrice = freezed,Object? rating = freezed,Object? category = null,Object? hasAiTryOn = null,}) {
  return _then(_ProductSummaryModel(
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
