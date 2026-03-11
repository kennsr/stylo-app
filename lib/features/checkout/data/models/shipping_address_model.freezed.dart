// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shipping_address_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShippingAddressModel {

 String get id;@JsonKey(name: 'receiver_name') String get receiverName; String get phone; String get street; String get city; String get province;@JsonKey(name: 'postal_code') String get postalCode;@JsonKey(name: 'is_default') bool get isDefault; String? get label;
/// Create a copy of ShippingAddressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShippingAddressModelCopyWith<ShippingAddressModel> get copyWith => _$ShippingAddressModelCopyWithImpl<ShippingAddressModel>(this as ShippingAddressModel, _$identity);

  /// Serializes this ShippingAddressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShippingAddressModel&&(identical(other.id, id) || other.id == id)&&(identical(other.receiverName, receiverName) || other.receiverName == receiverName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.street, street) || other.street == street)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,receiverName,phone,street,city,province,postalCode,isDefault,label);

@override
String toString() {
  return 'ShippingAddressModel(id: $id, receiverName: $receiverName, phone: $phone, street: $street, city: $city, province: $province, postalCode: $postalCode, isDefault: $isDefault, label: $label)';
}


}

/// @nodoc
abstract mixin class $ShippingAddressModelCopyWith<$Res>  {
  factory $ShippingAddressModelCopyWith(ShippingAddressModel value, $Res Function(ShippingAddressModel) _then) = _$ShippingAddressModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'receiver_name') String receiverName, String phone, String street, String city, String province,@JsonKey(name: 'postal_code') String postalCode,@JsonKey(name: 'is_default') bool isDefault, String? label
});




}
/// @nodoc
class _$ShippingAddressModelCopyWithImpl<$Res>
    implements $ShippingAddressModelCopyWith<$Res> {
  _$ShippingAddressModelCopyWithImpl(this._self, this._then);

  final ShippingAddressModel _self;
  final $Res Function(ShippingAddressModel) _then;

/// Create a copy of ShippingAddressModel
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


/// Adds pattern-matching-related methods to [ShippingAddressModel].
extension ShippingAddressModelPatterns on ShippingAddressModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShippingAddressModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShippingAddressModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShippingAddressModel value)  $default,){
final _that = this;
switch (_that) {
case _ShippingAddressModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShippingAddressModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShippingAddressModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'receiver_name')  String receiverName,  String phone,  String street,  String city,  String province, @JsonKey(name: 'postal_code')  String postalCode, @JsonKey(name: 'is_default')  bool isDefault,  String? label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShippingAddressModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'receiver_name')  String receiverName,  String phone,  String street,  String city,  String province, @JsonKey(name: 'postal_code')  String postalCode, @JsonKey(name: 'is_default')  bool isDefault,  String? label)  $default,) {final _that = this;
switch (_that) {
case _ShippingAddressModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'receiver_name')  String receiverName,  String phone,  String street,  String city,  String province, @JsonKey(name: 'postal_code')  String postalCode, @JsonKey(name: 'is_default')  bool isDefault,  String? label)?  $default,) {final _that = this;
switch (_that) {
case _ShippingAddressModel() when $default != null:
return $default(_that.id,_that.receiverName,_that.phone,_that.street,_that.city,_that.province,_that.postalCode,_that.isDefault,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShippingAddressModel implements ShippingAddressModel {
  const _ShippingAddressModel({required this.id, @JsonKey(name: 'receiver_name') required this.receiverName, required this.phone, required this.street, required this.city, required this.province, @JsonKey(name: 'postal_code') required this.postalCode, @JsonKey(name: 'is_default') this.isDefault = false, this.label});
  factory _ShippingAddressModel.fromJson(Map<String, dynamic> json) => _$ShippingAddressModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'receiver_name') final  String receiverName;
@override final  String phone;
@override final  String street;
@override final  String city;
@override final  String province;
@override@JsonKey(name: 'postal_code') final  String postalCode;
@override@JsonKey(name: 'is_default') final  bool isDefault;
@override final  String? label;

/// Create a copy of ShippingAddressModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShippingAddressModelCopyWith<_ShippingAddressModel> get copyWith => __$ShippingAddressModelCopyWithImpl<_ShippingAddressModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShippingAddressModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShippingAddressModel&&(identical(other.id, id) || other.id == id)&&(identical(other.receiverName, receiverName) || other.receiverName == receiverName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.street, street) || other.street == street)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,receiverName,phone,street,city,province,postalCode,isDefault,label);

@override
String toString() {
  return 'ShippingAddressModel(id: $id, receiverName: $receiverName, phone: $phone, street: $street, city: $city, province: $province, postalCode: $postalCode, isDefault: $isDefault, label: $label)';
}


}

/// @nodoc
abstract mixin class _$ShippingAddressModelCopyWith<$Res> implements $ShippingAddressModelCopyWith<$Res> {
  factory _$ShippingAddressModelCopyWith(_ShippingAddressModel value, $Res Function(_ShippingAddressModel) _then) = __$ShippingAddressModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'receiver_name') String receiverName, String phone, String street, String city, String province,@JsonKey(name: 'postal_code') String postalCode,@JsonKey(name: 'is_default') bool isDefault, String? label
});




}
/// @nodoc
class __$ShippingAddressModelCopyWithImpl<$Res>
    implements _$ShippingAddressModelCopyWith<$Res> {
  __$ShippingAddressModelCopyWithImpl(this._self, this._then);

  final _ShippingAddressModel _self;
  final $Res Function(_ShippingAddressModel) _then;

/// Create a copy of ShippingAddressModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? receiverName = null,Object? phone = null,Object? street = null,Object? city = null,Object? province = null,Object? postalCode = null,Object? isDefault = null,Object? label = freezed,}) {
  return _then(_ShippingAddressModel(
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
