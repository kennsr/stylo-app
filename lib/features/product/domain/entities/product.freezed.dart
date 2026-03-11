// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Product {

 String get id; String get name; String get description; double get price; double? get discountPrice; String get category; List<String> get images; List<ProductVariant> get variants; double get rating; int get reviewCount; int get stock; bool get isFeatured; bool get hasAiTryOn;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.category, category) || other.category == category)&& DeepCollectionEquality().equals(other.images, images)&& DeepCollectionEquality().equals(other.variants, variants)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.hasAiTryOn, hasAiTryOn) || other.hasAiTryOn == hasAiTryOn));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,discountPrice,category, DeepCollectionEquality().hash(images), DeepCollectionEquality().hash(variants),rating,reviewCount,stock,isFeatured,hasAiTryOn);

@override
String toString() {
  return 'Product(id: $id, name: $name, description: $description, price: $price, discountPrice: $discountPrice, category: $category, images: $images, variants: $variants, rating: $rating, reviewCount: $reviewCount, stock: $stock, isFeatured: $isFeatured, hasAiTryOn: $hasAiTryOn)';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, double price, double? discountPrice, String category, List<String> images, List<ProductVariant> variants, double rating, int reviewCount, int stock, bool isFeatured, bool hasAiTryOn
});




}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? price = null,Object? discountPrice = freezed,Object? category = null,Object? images = null,Object? variants = null,Object? rating = null,Object? reviewCount = null,Object? stock = null,Object? isFeatured = null,Object? hasAiTryOn = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,variants: null == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<ProductVariant>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,hasAiTryOn: null == hasAiTryOn ? _self.hasAiTryOn : hasAiTryOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  double price,  double? discountPrice,  String category,  List<String> images,  List<ProductVariant> variants,  double rating,  int reviewCount,  int stock,  bool isFeatured,  bool hasAiTryOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.discountPrice,_that.category,_that.images,_that.variants,_that.rating,_that.reviewCount,_that.stock,_that.isFeatured,_that.hasAiTryOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  double price,  double? discountPrice,  String category,  List<String> images,  List<ProductVariant> variants,  double rating,  int reviewCount,  int stock,  bool isFeatured,  bool hasAiTryOn)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.name,_that.description,_that.price,_that.discountPrice,_that.category,_that.images,_that.variants,_that.rating,_that.reviewCount,_that.stock,_that.isFeatured,_that.hasAiTryOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  double price,  double? discountPrice,  String category,  List<String> images,  List<ProductVariant> variants,  double rating,  int reviewCount,  int stock,  bool isFeatured,  bool hasAiTryOn)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.discountPrice,_that.category,_that.images,_that.variants,_that.rating,_that.reviewCount,_that.stock,_that.isFeatured,_that.hasAiTryOn);case _:
  return null;

}
}

}

/// @nodoc


class _Product implements Product {
  const _Product({required this.id, required this.name, required this.description, required this.price, this.discountPrice, required this.category, required final  List<String> images, required final  List<ProductVariant> variants, required this.rating, required this.reviewCount, required this.stock, this.isFeatured = false, this.hasAiTryOn = false}): _images = images,_variants = variants;
  

@override final  String id;
@override final  String name;
@override final  String description;
@override final  double price;
@override final  double? discountPrice;
@override final  String category;
 final  List<String> _images;
@override List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

 final  List<ProductVariant> _variants;
@override List<ProductVariant> get variants {
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_variants);
}

@override final  double rating;
@override final  int reviewCount;
@override final  int stock;
@override@JsonKey() final  bool isFeatured;
@override@JsonKey() final  bool hasAiTryOn;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.category, category) || other.category == category)&& DeepCollectionEquality().equals(other._images, _images)&& DeepCollectionEquality().equals(other._variants, _variants)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.hasAiTryOn, hasAiTryOn) || other.hasAiTryOn == hasAiTryOn));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,discountPrice,category, DeepCollectionEquality().hash(_images), DeepCollectionEquality().hash(_variants),rating,reviewCount,stock,isFeatured,hasAiTryOn);

@override
String toString() {
  return 'Product(id: $id, name: $name, description: $description, price: $price, discountPrice: $discountPrice, category: $category, images: $images, variants: $variants, rating: $rating, reviewCount: $reviewCount, stock: $stock, isFeatured: $isFeatured, hasAiTryOn: $hasAiTryOn)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, double price, double? discountPrice, String category, List<String> images, List<ProductVariant> variants, double rating, int reviewCount, int stock, bool isFeatured, bool hasAiTryOn
});




}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? price = null,Object? discountPrice = freezed,Object? category = null,Object? images = null,Object? variants = null,Object? rating = null,Object? reviewCount = null,Object? stock = null,Object? isFeatured = null,Object? hasAiTryOn = null,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,variants: null == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<ProductVariant>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,hasAiTryOn: null == hasAiTryOn ? _self.hasAiTryOn : hasAiTryOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
