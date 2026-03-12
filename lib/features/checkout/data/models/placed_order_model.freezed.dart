// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'placed_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlacedOrderModel {

 String get id;@JsonKey(name: 'order_number') String get orderNumber; List<CartItemRefModel> get items; ShippingAddressModel get address; ShippingOptionModel get shipping;@JsonKey(name: 'payment_method') String get paymentMethod; double get subtotal;@JsonKey(name: 'shipping_cost') double get shippingCost; double get total; String get status;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of PlacedOrderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacedOrderModelCopyWith<PlacedOrderModel> get copyWith => _$PlacedOrderModelCopyWithImpl<PlacedOrderModel>(this as PlacedOrderModel, _$identity);

  /// Serializes this PlacedOrderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacedOrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.address, address) || other.address == address)&&(identical(other.shipping, shipping) || other.shipping == shipping)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.shippingCost, shippingCost) || other.shippingCost == shippingCost)&&(identical(other.total, total) || other.total == total)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,const DeepCollectionEquality().hash(items),address,shipping,paymentMethod,subtotal,shippingCost,total,status,createdAt);

@override
String toString() {
  return 'PlacedOrderModel(id: $id, orderNumber: $orderNumber, items: $items, address: $address, shipping: $shipping, paymentMethod: $paymentMethod, subtotal: $subtotal, shippingCost: $shippingCost, total: $total, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PlacedOrderModelCopyWith<$Res>  {
  factory $PlacedOrderModelCopyWith(PlacedOrderModel value, $Res Function(PlacedOrderModel) _then) = _$PlacedOrderModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'order_number') String orderNumber, List<CartItemRefModel> items, ShippingAddressModel address, ShippingOptionModel shipping,@JsonKey(name: 'payment_method') String paymentMethod, double subtotal,@JsonKey(name: 'shipping_cost') double shippingCost, double total, String status,@JsonKey(name: 'created_at') DateTime createdAt
});


$ShippingAddressModelCopyWith<$Res> get address;$ShippingOptionModelCopyWith<$Res> get shipping;

}
/// @nodoc
class _$PlacedOrderModelCopyWithImpl<$Res>
    implements $PlacedOrderModelCopyWith<$Res> {
  _$PlacedOrderModelCopyWithImpl(this._self, this._then);

  final PlacedOrderModel _self;
  final $Res Function(PlacedOrderModel) _then;

/// Create a copy of PlacedOrderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNumber = null,Object? items = null,Object? address = null,Object? shipping = null,Object? paymentMethod = null,Object? subtotal = null,Object? shippingCost = null,Object? total = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemRefModel>,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as ShippingAddressModel,shipping: null == shipping ? _self.shipping : shipping // ignore: cast_nullable_to_non_nullable
as ShippingOptionModel,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,shippingCost: null == shippingCost ? _self.shippingCost : shippingCost // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of PlacedOrderModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingAddressModelCopyWith<$Res> get address {
  
  return $ShippingAddressModelCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of PlacedOrderModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingOptionModelCopyWith<$Res> get shipping {
  
  return $ShippingOptionModelCopyWith<$Res>(_self.shipping, (value) {
    return _then(_self.copyWith(shipping: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlacedOrderModel].
extension PlacedOrderModelPatterns on PlacedOrderModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacedOrderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacedOrderModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacedOrderModel value)  $default,){
final _that = this;
switch (_that) {
case _PlacedOrderModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacedOrderModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlacedOrderModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'order_number')  String orderNumber,  List<CartItemRefModel> items,  ShippingAddressModel address,  ShippingOptionModel shipping, @JsonKey(name: 'payment_method')  String paymentMethod,  double subtotal, @JsonKey(name: 'shipping_cost')  double shippingCost,  double total,  String status, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacedOrderModel() when $default != null:
return $default(_that.id,_that.orderNumber,_that.items,_that.address,_that.shipping,_that.paymentMethod,_that.subtotal,_that.shippingCost,_that.total,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'order_number')  String orderNumber,  List<CartItemRefModel> items,  ShippingAddressModel address,  ShippingOptionModel shipping, @JsonKey(name: 'payment_method')  String paymentMethod,  double subtotal, @JsonKey(name: 'shipping_cost')  double shippingCost,  double total,  String status, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _PlacedOrderModel():
return $default(_that.id,_that.orderNumber,_that.items,_that.address,_that.shipping,_that.paymentMethod,_that.subtotal,_that.shippingCost,_that.total,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'order_number')  String orderNumber,  List<CartItemRefModel> items,  ShippingAddressModel address,  ShippingOptionModel shipping, @JsonKey(name: 'payment_method')  String paymentMethod,  double subtotal, @JsonKey(name: 'shipping_cost')  double shippingCost,  double total,  String status, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PlacedOrderModel() when $default != null:
return $default(_that.id,_that.orderNumber,_that.items,_that.address,_that.shipping,_that.paymentMethod,_that.subtotal,_that.shippingCost,_that.total,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlacedOrderModel implements PlacedOrderModel {
  const _PlacedOrderModel({required this.id, @JsonKey(name: 'order_number') required this.orderNumber, required final  List<CartItemRefModel> items, required this.address, required this.shipping, @JsonKey(name: 'payment_method') required this.paymentMethod, required this.subtotal, @JsonKey(name: 'shipping_cost') required this.shippingCost, required this.total, required this.status, @JsonKey(name: 'created_at') required this.createdAt}): _items = items;
  factory _PlacedOrderModel.fromJson(Map<String, dynamic> json) => _$PlacedOrderModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'order_number') final  String orderNumber;
 final  List<CartItemRefModel> _items;
@override List<CartItemRefModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  ShippingAddressModel address;
@override final  ShippingOptionModel shipping;
@override@JsonKey(name: 'payment_method') final  String paymentMethod;
@override final  double subtotal;
@override@JsonKey(name: 'shipping_cost') final  double shippingCost;
@override final  double total;
@override final  String status;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of PlacedOrderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacedOrderModelCopyWith<_PlacedOrderModel> get copyWith => __$PlacedOrderModelCopyWithImpl<_PlacedOrderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlacedOrderModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacedOrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.address, address) || other.address == address)&&(identical(other.shipping, shipping) || other.shipping == shipping)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.shippingCost, shippingCost) || other.shippingCost == shippingCost)&&(identical(other.total, total) || other.total == total)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,const DeepCollectionEquality().hash(_items),address,shipping,paymentMethod,subtotal,shippingCost,total,status,createdAt);

@override
String toString() {
  return 'PlacedOrderModel(id: $id, orderNumber: $orderNumber, items: $items, address: $address, shipping: $shipping, paymentMethod: $paymentMethod, subtotal: $subtotal, shippingCost: $shippingCost, total: $total, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PlacedOrderModelCopyWith<$Res> implements $PlacedOrderModelCopyWith<$Res> {
  factory _$PlacedOrderModelCopyWith(_PlacedOrderModel value, $Res Function(_PlacedOrderModel) _then) = __$PlacedOrderModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'order_number') String orderNumber, List<CartItemRefModel> items, ShippingAddressModel address, ShippingOptionModel shipping,@JsonKey(name: 'payment_method') String paymentMethod, double subtotal,@JsonKey(name: 'shipping_cost') double shippingCost, double total, String status,@JsonKey(name: 'created_at') DateTime createdAt
});


@override $ShippingAddressModelCopyWith<$Res> get address;@override $ShippingOptionModelCopyWith<$Res> get shipping;

}
/// @nodoc
class __$PlacedOrderModelCopyWithImpl<$Res>
    implements _$PlacedOrderModelCopyWith<$Res> {
  __$PlacedOrderModelCopyWithImpl(this._self, this._then);

  final _PlacedOrderModel _self;
  final $Res Function(_PlacedOrderModel) _then;

/// Create a copy of PlacedOrderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNumber = null,Object? items = null,Object? address = null,Object? shipping = null,Object? paymentMethod = null,Object? subtotal = null,Object? shippingCost = null,Object? total = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_PlacedOrderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemRefModel>,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as ShippingAddressModel,shipping: null == shipping ? _self.shipping : shipping // ignore: cast_nullable_to_non_nullable
as ShippingOptionModel,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,shippingCost: null == shippingCost ? _self.shippingCost : shippingCost // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of PlacedOrderModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingAddressModelCopyWith<$Res> get address {
  
  return $ShippingAddressModelCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of PlacedOrderModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingOptionModelCopyWith<$Res> get shipping {
  
  return $ShippingOptionModelCopyWith<$Res>(_self.shipping, (value) {
    return _then(_self.copyWith(shipping: value));
  });
}
}

// dart format on
