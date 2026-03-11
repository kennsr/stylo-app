// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fit_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FitProfileModel {

@JsonKey(name: 'user_id') String? get userId; double? get height; double? get weight; double? get chest; double? get waist; double? get hips;@JsonKey(name: 'preferred_size') String? get preferredSize;
/// Create a copy of FitProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FitProfileModelCopyWith<FitProfileModel> get copyWith => _$FitProfileModelCopyWithImpl<FitProfileModel>(this as FitProfileModel, _$identity);

  /// Serializes this FitProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FitProfileModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.chest, chest) || other.chest == chest)&&(identical(other.waist, waist) || other.waist == waist)&&(identical(other.hips, hips) || other.hips == hips)&&(identical(other.preferredSize, preferredSize) || other.preferredSize == preferredSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,height,weight,chest,waist,hips,preferredSize);

@override
String toString() {
  return 'FitProfileModel(userId: $userId, height: $height, weight: $weight, chest: $chest, waist: $waist, hips: $hips, preferredSize: $preferredSize)';
}


}

/// @nodoc
abstract mixin class $FitProfileModelCopyWith<$Res>  {
  factory $FitProfileModelCopyWith(FitProfileModel value, $Res Function(FitProfileModel) _then) = _$FitProfileModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String? userId, double? height, double? weight, double? chest, double? waist, double? hips,@JsonKey(name: 'preferred_size') String? preferredSize
});




}
/// @nodoc
class _$FitProfileModelCopyWithImpl<$Res>
    implements $FitProfileModelCopyWith<$Res> {
  _$FitProfileModelCopyWithImpl(this._self, this._then);

  final FitProfileModel _self;
  final $Res Function(FitProfileModel) _then;

/// Create a copy of FitProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? height = freezed,Object? weight = freezed,Object? chest = freezed,Object? waist = freezed,Object? hips = freezed,Object? preferredSize = freezed,}) {
  return _then(_self.copyWith(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,chest: freezed == chest ? _self.chest : chest // ignore: cast_nullable_to_non_nullable
as double?,waist: freezed == waist ? _self.waist : waist // ignore: cast_nullable_to_non_nullable
as double?,hips: freezed == hips ? _self.hips : hips // ignore: cast_nullable_to_non_nullable
as double?,preferredSize: freezed == preferredSize ? _self.preferredSize : preferredSize // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FitProfileModel].
extension FitProfileModelPatterns on FitProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FitProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FitProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FitProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _FitProfileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FitProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _FitProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String? userId,  double? height,  double? weight,  double? chest,  double? waist,  double? hips, @JsonKey(name: 'preferred_size')  String? preferredSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FitProfileModel() when $default != null:
return $default(_that.userId,_that.height,_that.weight,_that.chest,_that.waist,_that.hips,_that.preferredSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String? userId,  double? height,  double? weight,  double? chest,  double? waist,  double? hips, @JsonKey(name: 'preferred_size')  String? preferredSize)  $default,) {final _that = this;
switch (_that) {
case _FitProfileModel():
return $default(_that.userId,_that.height,_that.weight,_that.chest,_that.waist,_that.hips,_that.preferredSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String? userId,  double? height,  double? weight,  double? chest,  double? waist,  double? hips, @JsonKey(name: 'preferred_size')  String? preferredSize)?  $default,) {final _that = this;
switch (_that) {
case _FitProfileModel() when $default != null:
return $default(_that.userId,_that.height,_that.weight,_that.chest,_that.waist,_that.hips,_that.preferredSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FitProfileModel implements FitProfileModel {
  const _FitProfileModel({@JsonKey(name: 'user_id') this.userId, this.height, this.weight, this.chest, this.waist, this.hips, @JsonKey(name: 'preferred_size') this.preferredSize});
  factory _FitProfileModel.fromJson(Map<String, dynamic> json) => _$FitProfileModelFromJson(json);

@override@JsonKey(name: 'user_id') final  String? userId;
@override final  double? height;
@override final  double? weight;
@override final  double? chest;
@override final  double? waist;
@override final  double? hips;
@override@JsonKey(name: 'preferred_size') final  String? preferredSize;

/// Create a copy of FitProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FitProfileModelCopyWith<_FitProfileModel> get copyWith => __$FitProfileModelCopyWithImpl<_FitProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FitProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FitProfileModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.chest, chest) || other.chest == chest)&&(identical(other.waist, waist) || other.waist == waist)&&(identical(other.hips, hips) || other.hips == hips)&&(identical(other.preferredSize, preferredSize) || other.preferredSize == preferredSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,height,weight,chest,waist,hips,preferredSize);

@override
String toString() {
  return 'FitProfileModel(userId: $userId, height: $height, weight: $weight, chest: $chest, waist: $waist, hips: $hips, preferredSize: $preferredSize)';
}


}

/// @nodoc
abstract mixin class _$FitProfileModelCopyWith<$Res> implements $FitProfileModelCopyWith<$Res> {
  factory _$FitProfileModelCopyWith(_FitProfileModel value, $Res Function(_FitProfileModel) _then) = __$FitProfileModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String? userId, double? height, double? weight, double? chest, double? waist, double? hips,@JsonKey(name: 'preferred_size') String? preferredSize
});




}
/// @nodoc
class __$FitProfileModelCopyWithImpl<$Res>
    implements _$FitProfileModelCopyWith<$Res> {
  __$FitProfileModelCopyWithImpl(this._self, this._then);

  final _FitProfileModel _self;
  final $Res Function(_FitProfileModel) _then;

/// Create a copy of FitProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = freezed,Object? height = freezed,Object? weight = freezed,Object? chest = freezed,Object? waist = freezed,Object? hips = freezed,Object? preferredSize = freezed,}) {
  return _then(_FitProfileModel(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,chest: freezed == chest ? _self.chest : chest // ignore: cast_nullable_to_non_nullable
as double?,waist: freezed == waist ? _self.waist : waist // ignore: cast_nullable_to_non_nullable
as double?,hips: freezed == hips ? _self.hips : hips // ignore: cast_nullable_to_non_nullable
as double?,preferredSize: freezed == preferredSize ? _self.preferredSize : preferredSize // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
