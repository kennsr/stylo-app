// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'try_on_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TryOnResultModel {

 String get id;@JsonKey(name: 'product_id') String get productId;@JsonKey(name: 'original_image_url') String get originalImageUrl;@JsonKey(name: 'result_image_url') String get resultImageUrl;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'is_saved') bool get isSaved;
/// Create a copy of TryOnResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TryOnResultModelCopyWith<TryOnResultModel> get copyWith => _$TryOnResultModelCopyWithImpl<TryOnResultModel>(this as TryOnResultModel, _$identity);

  /// Serializes this TryOnResultModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TryOnResultModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.originalImageUrl, originalImageUrl) || other.originalImageUrl == originalImageUrl)&&(identical(other.resultImageUrl, resultImageUrl) || other.resultImageUrl == resultImageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,originalImageUrl,resultImageUrl,createdAt,isSaved);

@override
String toString() {
  return 'TryOnResultModel(id: $id, productId: $productId, originalImageUrl: $originalImageUrl, resultImageUrl: $resultImageUrl, createdAt: $createdAt, isSaved: $isSaved)';
}


}

/// @nodoc
abstract mixin class $TryOnResultModelCopyWith<$Res>  {
  factory $TryOnResultModelCopyWith(TryOnResultModel value, $Res Function(TryOnResultModel) _then) = _$TryOnResultModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'product_id') String productId,@JsonKey(name: 'original_image_url') String originalImageUrl,@JsonKey(name: 'result_image_url') String resultImageUrl,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'is_saved') bool isSaved
});




}
/// @nodoc
class _$TryOnResultModelCopyWithImpl<$Res>
    implements $TryOnResultModelCopyWith<$Res> {
  _$TryOnResultModelCopyWithImpl(this._self, this._then);

  final TryOnResultModel _self;
  final $Res Function(TryOnResultModel) _then;

/// Create a copy of TryOnResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? originalImageUrl = null,Object? resultImageUrl = null,Object? createdAt = null,Object? isSaved = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,originalImageUrl: null == originalImageUrl ? _self.originalImageUrl : originalImageUrl // ignore: cast_nullable_to_non_nullable
as String,resultImageUrl: null == resultImageUrl ? _self.resultImageUrl : resultImageUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TryOnResultModel].
extension TryOnResultModelPatterns on TryOnResultModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TryOnResultModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TryOnResultModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TryOnResultModel value)  $default,){
final _that = this;
switch (_that) {
case _TryOnResultModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TryOnResultModel value)?  $default,){
final _that = this;
switch (_that) {
case _TryOnResultModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'product_id')  String productId, @JsonKey(name: 'original_image_url')  String originalImageUrl, @JsonKey(name: 'result_image_url')  String resultImageUrl, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'is_saved')  bool isSaved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TryOnResultModel() when $default != null:
return $default(_that.id,_that.productId,_that.originalImageUrl,_that.resultImageUrl,_that.createdAt,_that.isSaved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'product_id')  String productId, @JsonKey(name: 'original_image_url')  String originalImageUrl, @JsonKey(name: 'result_image_url')  String resultImageUrl, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'is_saved')  bool isSaved)  $default,) {final _that = this;
switch (_that) {
case _TryOnResultModel():
return $default(_that.id,_that.productId,_that.originalImageUrl,_that.resultImageUrl,_that.createdAt,_that.isSaved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'product_id')  String productId, @JsonKey(name: 'original_image_url')  String originalImageUrl, @JsonKey(name: 'result_image_url')  String resultImageUrl, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'is_saved')  bool isSaved)?  $default,) {final _that = this;
switch (_that) {
case _TryOnResultModel() when $default != null:
return $default(_that.id,_that.productId,_that.originalImageUrl,_that.resultImageUrl,_that.createdAt,_that.isSaved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TryOnResultModel implements TryOnResultModel {
  const _TryOnResultModel({required this.id, @JsonKey(name: 'product_id') required this.productId, @JsonKey(name: 'original_image_url') required this.originalImageUrl, @JsonKey(name: 'result_image_url') required this.resultImageUrl, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'is_saved') this.isSaved = false});
  factory _TryOnResultModel.fromJson(Map<String, dynamic> json) => _$TryOnResultModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'product_id') final  String productId;
@override@JsonKey(name: 'original_image_url') final  String originalImageUrl;
@override@JsonKey(name: 'result_image_url') final  String resultImageUrl;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'is_saved') final  bool isSaved;

/// Create a copy of TryOnResultModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TryOnResultModelCopyWith<_TryOnResultModel> get copyWith => __$TryOnResultModelCopyWithImpl<_TryOnResultModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TryOnResultModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TryOnResultModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.originalImageUrl, originalImageUrl) || other.originalImageUrl == originalImageUrl)&&(identical(other.resultImageUrl, resultImageUrl) || other.resultImageUrl == resultImageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,originalImageUrl,resultImageUrl,createdAt,isSaved);

@override
String toString() {
  return 'TryOnResultModel(id: $id, productId: $productId, originalImageUrl: $originalImageUrl, resultImageUrl: $resultImageUrl, createdAt: $createdAt, isSaved: $isSaved)';
}


}

/// @nodoc
abstract mixin class _$TryOnResultModelCopyWith<$Res> implements $TryOnResultModelCopyWith<$Res> {
  factory _$TryOnResultModelCopyWith(_TryOnResultModel value, $Res Function(_TryOnResultModel) _then) = __$TryOnResultModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'product_id') String productId,@JsonKey(name: 'original_image_url') String originalImageUrl,@JsonKey(name: 'result_image_url') String resultImageUrl,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'is_saved') bool isSaved
});




}
/// @nodoc
class __$TryOnResultModelCopyWithImpl<$Res>
    implements _$TryOnResultModelCopyWith<$Res> {
  __$TryOnResultModelCopyWithImpl(this._self, this._then);

  final _TryOnResultModel _self;
  final $Res Function(_TryOnResultModel) _then;

/// Create a copy of TryOnResultModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? originalImageUrl = null,Object? resultImageUrl = null,Object? createdAt = null,Object? isSaved = null,}) {
  return _then(_TryOnResultModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,originalImageUrl: null == originalImageUrl ? _self.originalImageUrl : originalImageUrl // ignore: cast_nullable_to_non_nullable
as String,resultImageUrl: null == resultImageUrl ? _self.resultImageUrl : resultImageUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
