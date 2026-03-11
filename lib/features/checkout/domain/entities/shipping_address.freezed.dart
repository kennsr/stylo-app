// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shipping_address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShippingAddress {

 String get id; String get receiverName; String get phone; String get street; String get city; String get province; String get postalCode; bool get isDefault; String? get label;
/// Create a copy of ShippingAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShippingAddressCopyWith<ShippingAddress> get copyWith => _$ShippingAddressCopyWithImpl<ShippingAddress>(this as ShippingAddress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShippingAddress&&(identical(other.id, id) || other.id == id)&&(identical(other.receiverName, receiverName) || other.receiverName == receiverName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.street, street) || other.street == street)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,id,receiverName,phone,street,city,province,postalCode,isDefault,label);

@override
String toString() {
  return 'ShippingAddress(id: $id, receiverName: $receiverName, phone: $phone, street: $street, city: $city, province: $province, postalCode: $postalCode, isDefault: $isDefault, label: $label)';
}


}

/// @nodoc
abstract mixin class $ShippingAddressCopyWith<$Res>  {
  factory $ShippingAddressCopyWith(ShippingAddress value, $Res Function(ShippingAddress) _then) = _$ShippingAddressCopyWithImpl;
@useResult
$Res call({
 String id, String receiverName, String phone, String street, String city, String province, String postalCode, bool isDefault, String? label
});




}
/// @nodoc
class _$ShippingAddressCopyWithImpl<$Res>
    implements $ShippingAddressCopyWith<$Res> {
  _$ShippingAddressCopyWithImpl(this._self, this._then);

  final ShippingAddress _self;
  final $Res Function(ShippingAddress) _then;

/// Create a copy of ShippingAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? receiverName = null,Object? phone = null,Object? street = null,Object? city = null,Object? province = null,Object? postalCode = null,Object? isDefault = null,Object? label = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,receiverName: null == receiverName ? _self.receiverName : receiverName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,postalCode: null == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShippingAddress].
extension ShippingAddressPatterns on ShippingAddress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShippingAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShippingAddress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShippingAddress value)  $default,){
final _that = this;
switch (_that) {
case _ShippingAddress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShippingAddress value)?  $default,){
final _that = this;
switch (_that) {
case _ShippingAddress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String receiverName,  String phone,  String street,  String city,  String province,  String postalCode,  bool isDefault,  String? label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShippingAddress() when $default != null:
return $default(_that.id,_that.receiverName,_that.phone,_that.street,_that.city,_that.province,_that.postalCode,_that.isDefault,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String receiverName,  String phone,  String street,  String city,  String province,  String postalCode,  bool isDefault,  String? label)  $default,) {final _that = this;
switch (_that) {
case _ShippingAddress():
return $default(_that.id,_that.receiverName,_that.phone,_that.street,_that.city,_that.province,_that.postalCode,_that.isDefault,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String receiverName,  String phone,  String street,  String city,  String province,  String postalCode,  bool isDefault,  String? label)?  $default,) {final _that = this;
switch (_that) {
case _ShippingAddress() when $default != null:
return $default(_that.id,_that.receiverName,_that.phone,_that.street,_that.city,_that.province,_that.postalCode,_that.isDefault,_that.label);case _:
  return null;

}
}

}

/// @nodoc


class _ShippingAddress implements ShippingAddress {
  const _ShippingAddress({required this.id, required this.receiverName, required this.phone, required this.street, required this.city, required this.province, required this.postalCode, this.isDefault = false, this.label});
  

@override final  String id;
@override final  String receiverName;
@override final  String phone;
@override final  String street;
@override final  String city;
@override final  String province;
@override final  String postalCode;
@override@JsonKey() final  bool isDefault;
@override final  String? label;

/// Create a copy of ShippingAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShippingAddressCopyWith<_ShippingAddress> get copyWith => __$ShippingAddressCopyWithImpl<_ShippingAddress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShippingAddress&&(identical(other.id, id) || other.id == id)&&(identical(other.receiverName, receiverName) || other.receiverName == receiverName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.street, street) || other.street == street)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,id,receiverName,phone,street,city,province,postalCode,isDefault,label);

@override
String toString() {
  return 'ShippingAddress(id: $id, receiverName: $receiverName, phone: $phone, street: $street, city: $city, province: $province, postalCode: $postalCode, isDefault: $isDefault, label: $label)';
}


}

/// @nodoc
abstract mixin class _$ShippingAddressCopyWith<$Res> implements $ShippingAddressCopyWith<$Res> {
  factory _$ShippingAddressCopyWith(_ShippingAddress value, $Res Function(_ShippingAddress) _then) = __$ShippingAddressCopyWithImpl;
@override @useResult
$Res call({
 String id, String receiverName, String phone, String street, String city, String province, String postalCode, bool isDefault, String? label
});




}
/// @nodoc
class __$ShippingAddressCopyWithImpl<$Res>
    implements _$ShippingAddressCopyWith<$Res> {
  __$ShippingAddressCopyWithImpl(this._self, this._then);

  final _ShippingAddress _self;
  final $Res Function(_ShippingAddress) _then;

/// Create a copy of ShippingAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? receiverName = null,Object? phone = null,Object? street = null,Object? city = null,Object? province = null,Object? postalCode = null,Object? isDefault = null,Object? label = freezed,}) {
  return _then(_ShippingAddress(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,receiverName: null == receiverName ? _self.receiverName : receiverName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,postalCode: null == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
