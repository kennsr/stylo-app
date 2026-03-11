// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shipping_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShippingOption {

 String get id; String get courier; String get service; double get cost; int get estimatedDays;
/// Create a copy of ShippingOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShippingOptionCopyWith<ShippingOption> get copyWith => _$ShippingOptionCopyWithImpl<ShippingOption>(this as ShippingOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShippingOption&&(identical(other.id, id) || other.id == id)&&(identical(other.courier, courier) || other.courier == courier)&&(identical(other.service, service) || other.service == service)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.estimatedDays, estimatedDays) || other.estimatedDays == estimatedDays));
}


@override
int get hashCode => Object.hash(runtimeType,id,courier,service,cost,estimatedDays);

@override
String toString() {
  return 'ShippingOption(id: $id, courier: $courier, service: $service, cost: $cost, estimatedDays: $estimatedDays)';
}


}

/// @nodoc
abstract mixin class $ShippingOptionCopyWith<$Res>  {
  factory $ShippingOptionCopyWith(ShippingOption value, $Res Function(ShippingOption) _then) = _$ShippingOptionCopyWithImpl;
@useResult
$Res call({
 String id, String courier, String service, double cost, int estimatedDays
});




}
/// @nodoc
class _$ShippingOptionCopyWithImpl<$Res>
    implements $ShippingOptionCopyWith<$Res> {
  _$ShippingOptionCopyWithImpl(this._self, this._then);

  final ShippingOption _self;
  final $Res Function(ShippingOption) _then;

/// Create a copy of ShippingOption
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


/// Adds pattern-matching-related methods to [ShippingOption].
extension ShippingOptionPatterns on ShippingOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShippingOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShippingOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShippingOption value)  $default,){
final _that = this;
switch (_that) {
case _ShippingOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShippingOption value)?  $default,){
final _that = this;
switch (_that) {
case _ShippingOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String courier,  String service,  double cost,  int estimatedDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShippingOption() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String courier,  String service,  double cost,  int estimatedDays)  $default,) {final _that = this;
switch (_that) {
case _ShippingOption():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String courier,  String service,  double cost,  int estimatedDays)?  $default,) {final _that = this;
switch (_that) {
case _ShippingOption() when $default != null:
return $default(_that.id,_that.courier,_that.service,_that.cost,_that.estimatedDays);case _:
  return null;

}
}

}

/// @nodoc


class _ShippingOption implements ShippingOption {
  const _ShippingOption({required this.id, required this.courier, required this.service, required this.cost, required this.estimatedDays});
  

@override final  String id;
@override final  String courier;
@override final  String service;
@override final  double cost;
@override final  int estimatedDays;

/// Create a copy of ShippingOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShippingOptionCopyWith<_ShippingOption> get copyWith => __$ShippingOptionCopyWithImpl<_ShippingOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShippingOption&&(identical(other.id, id) || other.id == id)&&(identical(other.courier, courier) || other.courier == courier)&&(identical(other.service, service) || other.service == service)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.estimatedDays, estimatedDays) || other.estimatedDays == estimatedDays));
}


@override
int get hashCode => Object.hash(runtimeType,id,courier,service,cost,estimatedDays);

@override
String toString() {
  return 'ShippingOption(id: $id, courier: $courier, service: $service, cost: $cost, estimatedDays: $estimatedDays)';
}


}

/// @nodoc
abstract mixin class _$ShippingOptionCopyWith<$Res> implements $ShippingOptionCopyWith<$Res> {
  factory _$ShippingOptionCopyWith(_ShippingOption value, $Res Function(_ShippingOption) _then) = __$ShippingOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String courier, String service, double cost, int estimatedDays
});




}
/// @nodoc
class __$ShippingOptionCopyWithImpl<$Res>
    implements _$ShippingOptionCopyWith<$Res> {
  __$ShippingOptionCopyWithImpl(this._self, this._then);

  final _ShippingOption _self;
  final $Res Function(_ShippingOption) _then;

/// Create a copy of ShippingOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? courier = null,Object? service = null,Object? cost = null,Object? estimatedDays = null,}) {
  return _then(_ShippingOption(
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
