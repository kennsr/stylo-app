// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'try_on_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TryOnResult {

 String get id; String get productId; String get originalImageUrl; String get resultImageUrl; DateTime get createdAt; bool get isSaved;
/// Create a copy of TryOnResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TryOnResultCopyWith<TryOnResult> get copyWith => _$TryOnResultCopyWithImpl<TryOnResult>(this as TryOnResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TryOnResult&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.originalImageUrl, originalImageUrl) || other.originalImageUrl == originalImageUrl)&&(identical(other.resultImageUrl, resultImageUrl) || other.resultImageUrl == resultImageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,originalImageUrl,resultImageUrl,createdAt,isSaved);

@override
String toString() {
  return 'TryOnResult(id: $id, productId: $productId, originalImageUrl: $originalImageUrl, resultImageUrl: $resultImageUrl, createdAt: $createdAt, isSaved: $isSaved)';
}


}

/// @nodoc
abstract mixin class $TryOnResultCopyWith<$Res>  {
  factory $TryOnResultCopyWith(TryOnResult value, $Res Function(TryOnResult) _then) = _$TryOnResultCopyWithImpl;
@useResult
$Res call({
 String id, String productId, String originalImageUrl, String resultImageUrl, DateTime createdAt, bool isSaved
});




}
/// @nodoc
class _$TryOnResultCopyWithImpl<$Res>
    implements $TryOnResultCopyWith<$Res> {
  _$TryOnResultCopyWithImpl(this._self, this._then);

  final TryOnResult _self;
  final $Res Function(TryOnResult) _then;

/// Create a copy of TryOnResult
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


/// Adds pattern-matching-related methods to [TryOnResult].
extension TryOnResultPatterns on TryOnResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TryOnResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TryOnResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TryOnResult value)  $default,){
final _that = this;
switch (_that) {
case _TryOnResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TryOnResult value)?  $default,){
final _that = this;
switch (_that) {
case _TryOnResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String productId,  String originalImageUrl,  String resultImageUrl,  DateTime createdAt,  bool isSaved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TryOnResult() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String productId,  String originalImageUrl,  String resultImageUrl,  DateTime createdAt,  bool isSaved)  $default,) {final _that = this;
switch (_that) {
case _TryOnResult():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String productId,  String originalImageUrl,  String resultImageUrl,  DateTime createdAt,  bool isSaved)?  $default,) {final _that = this;
switch (_that) {
case _TryOnResult() when $default != null:
return $default(_that.id,_that.productId,_that.originalImageUrl,_that.resultImageUrl,_that.createdAt,_that.isSaved);case _:
  return null;

}
}

}

/// @nodoc


class _TryOnResult implements TryOnResult {
  const _TryOnResult({required this.id, required this.productId, required this.originalImageUrl, required this.resultImageUrl, required this.createdAt, this.isSaved = false});
  

@override final  String id;
@override final  String productId;
@override final  String originalImageUrl;
@override final  String resultImageUrl;
@override final  DateTime createdAt;
@override@JsonKey() final  bool isSaved;

/// Create a copy of TryOnResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TryOnResultCopyWith<_TryOnResult> get copyWith => __$TryOnResultCopyWithImpl<_TryOnResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TryOnResult&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.originalImageUrl, originalImageUrl) || other.originalImageUrl == originalImageUrl)&&(identical(other.resultImageUrl, resultImageUrl) || other.resultImageUrl == resultImageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,originalImageUrl,resultImageUrl,createdAt,isSaved);

@override
String toString() {
  return 'TryOnResult(id: $id, productId: $productId, originalImageUrl: $originalImageUrl, resultImageUrl: $resultImageUrl, createdAt: $createdAt, isSaved: $isSaved)';
}


}

/// @nodoc
abstract mixin class _$TryOnResultCopyWith<$Res> implements $TryOnResultCopyWith<$Res> {
  factory _$TryOnResultCopyWith(_TryOnResult value, $Res Function(_TryOnResult) _then) = __$TryOnResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String productId, String originalImageUrl, String resultImageUrl, DateTime createdAt, bool isSaved
});




}
/// @nodoc
class __$TryOnResultCopyWithImpl<$Res>
    implements _$TryOnResultCopyWith<$Res> {
  __$TryOnResultCopyWithImpl(this._self, this._then);

  final _TryOnResult _self;
  final $Res Function(_TryOnResult) _then;

/// Create a copy of TryOnResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? originalImageUrl = null,Object? resultImageUrl = null,Object? createdAt = null,Object? isSaved = null,}) {
  return _then(_TryOnResult(
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
