// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shipping_option_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShippingOptionModel {

 String get id; String get courier; String get service; double get cost;@JsonKey(name: 'estimated_days') int get estimatedDays;
/// Create a copy of ShippingOptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShippingOptionModelCopyWith<ShippingOptionModel> get copyWith => _$ShippingOptionModelCopyWithImpl<ShippingOptionModel>(this as ShippingOptionModel, _$identity);

  /// Serializes this ShippingOptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShippingOptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.courier, courier) || other.courier == courier)&&(identical(other.service, service) || other.service == service)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.estimatedDays, estimatedDays) || other.estimatedDays == estimatedDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,courier,service,cost,estimatedDays);

@override
String toString() {
  return 'ShippingOptionModel(id: $id, courier: $courier, service: $service, cost: $cost, estimatedDays: $estimatedDays)';
}


}

/// @nodoc
abstract mixin class $ShippingOptionModelCopyWith<$Res>  {
  factory $ShippingOptionModelCopyWith(ShippingOptionModel value, $Res Function(ShippingOptionModel) _then) = _$ShippingOptionModelCopyWithImpl;
@useResult
$Res call({
 String id, String courier, String service, double cost,@JsonKey(name: 'estimated_days') int estimatedDays
});




}
/// @nodoc
class _$ShippingOptionModelCopyWithImpl<$Res>
    implements $ShippingOptionModelCopyWith<$Res> {
  _$ShippingOptionModelCopyWithImpl(this._self, this._then);

  final ShippingOptionModel _self;
  final $Res Function(ShippingOptionModel) _then;

/// Create a copy of ShippingOptionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? courier = null,Object? service = null,Object? cost = null,Object? estimatedDays = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,courier: null == courier ? _self.courier : courier // ignore: cast_nullable_to_non_nullable
as String,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,estimatedDays: null == estimatedDays ? _self.estimatedDays : estimatedDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShippingOptionModel].
extension ShippingOptionModelPatterns on ShippingOptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShippingOptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShippingOptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShippingOptionModel value)  $default,){
final _that = this;
switch (_that) {
case _ShippingOptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShippingOptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShippingOptionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String courier,  String service,  double cost, @JsonKey(name: 'estimated_days')  int estimatedDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShippingOptionModel() when $default != null:
return $default(_that.id,_that.courier,_that.service,_that.cost,_that.estimatedDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String courier,  String service,  double cost, @JsonKey(name: 'estimated_days')  int estimatedDays)  $default,) {final _that = this;
switch (_that) {
case _ShippingOptionModel():
return $default(_that.id,_that.courier,_that.service,_that.cost,_that.estimatedDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String courier,  String service,  double cost, @JsonKey(name: 'estimated_days')  int estimatedDays)?  $default,) {final _that = this;
switch (_that) {
case _ShippingOptionModel() when $default != null:
return $default(_that.id,_that.courier,_that.service,_that.cost,_that.estimatedDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShippingOptionModel implements ShippingOptionModel {
  const _ShippingOptionModel({required this.id, required this.courier, required this.service, required this.cost, @JsonKey(name: 'estimated_days') required this.estimatedDays});
  factory _ShippingOptionModel.fromJson(Map<String, dynamic> json) => _$ShippingOptionModelFromJson(json);

@override final  String id;
@override final  String courier;
@override final  String service;
@override final  double cost;
@override@JsonKey(name: 'estimated_days') final  int estimatedDays;

/// Create a copy of ShippingOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShippingOptionModelCopyWith<_ShippingOptionModel> get copyWith => __$ShippingOptionModelCopyWithImpl<_ShippingOptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShippingOptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShippingOptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.courier, courier) || other.courier == courier)&&(identical(other.service, service) || other.service == service)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.estimatedDays, estimatedDays) || other.estimatedDays == estimatedDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,courier,service,cost,estimatedDays);

@override
String toString() {
  return 'ShippingOptionModel(id: $id, courier: $courier, service: $service, cost: $cost, estimatedDays: $estimatedDays)';
}


}

/// @nodoc
abstract mixin class _$ShippingOptionModelCopyWith<$Res> implements $ShippingOptionModelCopyWith<$Res> {
  factory _$ShippingOptionModelCopyWith(_ShippingOptionModel value, $Res Function(_ShippingOptionModel) _then) = __$ShippingOptionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String courier, String service, double cost,@JsonKey(name: 'estimated_days') int estimatedDays
});




}
/// @nodoc
class __$ShippingOptionModelCopyWithImpl<$Res>
    implements _$ShippingOptionModelCopyWith<$Res> {
  __$ShippingOptionModelCopyWithImpl(this._self, this._then);

  final _ShippingOptionModel _self;
  final $Res Function(_ShippingOptionModel) _then;

/// Create a copy of ShippingOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? courier = null,Object? service = null,Object? cost = null,Object? estimatedDays = null,}) {
  return _then(_ShippingOptionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,courier: null == courier ? _self.courier : courier // ignore: cast_nullable_to_non_nullable
as String,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,estimatedDays: null == estimatedDays ? _self.estimatedDays : estimatedDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
