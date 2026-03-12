// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'placed_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlacedOrder {

 String get id; String get orderNumber; List<CartItemRef> get items; ShippingAddress get address; ShippingOption get shipping; String get paymentMethod; double get subtotal; double get shippingCost; double get total; String get status; DateTime get createdAt;
/// Create a copy of PlacedOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacedOrderCopyWith<PlacedOrder> get copyWith => _$PlacedOrderCopyWithImpl<PlacedOrder>(this as PlacedOrder, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacedOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.address, address) || other.address == address)&&(identical(other.shipping, shipping) || other.shipping == shipping)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.shippingCost, shippingCost) || other.shippingCost == shippingCost)&&(identical(other.total, total) || other.total == total)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,const DeepCollectionEquality().hash(items),address,shipping,paymentMethod,subtotal,shippingCost,total,status,createdAt);

@override
String toString() {
  return 'PlacedOrder(id: $id, orderNumber: $orderNumber, items: $items, address: $address, shipping: $shipping, paymentMethod: $paymentMethod, subtotal: $subtotal, shippingCost: $shippingCost, total: $total, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PlacedOrderCopyWith<$Res>  {
  factory $PlacedOrderCopyWith(PlacedOrder value, $Res Function(PlacedOrder) _then) = _$PlacedOrderCopyWithImpl;
@useResult
$Res call({
 String id, String orderNumber, List<CartItemRef> items, ShippingAddress address, ShippingOption shipping, String paymentMethod, double subtotal, double shippingCost, double total, String status, DateTime createdAt
});


$ShippingAddressCopyWith<$Res> get address;$ShippingOptionCopyWith<$Res> get shipping;

}
/// @nodoc
class _$PlacedOrderCopyWithImpl<$Res>
    implements $PlacedOrderCopyWith<$Res> {
  _$PlacedOrderCopyWithImpl(this._self, this._then);

  final PlacedOrder _self;
  final $Res Function(PlacedOrder) _then;

/// Create a copy of PlacedOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNumber = null,Object? items = null,Object? address = null,Object? shipping = null,Object? paymentMethod = null,Object? subtotal = null,Object? shippingCost = null,Object? total = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemRef>,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as ShippingAddress,shipping: null == shipping ? _self.shipping : shipping // ignore: cast_nullable_to_non_nullable
as ShippingOption,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,shippingCost: null == shippingCost ? _self.shippingCost : shippingCost // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of PlacedOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingAddressCopyWith<$Res> get address {
  
  return $ShippingAddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of PlacedOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingOptionCopyWith<$Res> get shipping {
  
  return $ShippingOptionCopyWith<$Res>(_self.shipping, (value) {
    return _then(_self.copyWith(shipping: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlacedOrder].
extension PlacedOrderPatterns on PlacedOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacedOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacedOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacedOrder value)  $default,){
final _that = this;
switch (_that) {
case _PlacedOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacedOrder value)?  $default,){
final _that = this;
switch (_that) {
case _PlacedOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderNumber,  List<CartItemRef> items,  ShippingAddress address,  ShippingOption shipping,  String paymentMethod,  double subtotal,  double shippingCost,  double total,  String status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacedOrder() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderNumber,  List<CartItemRef> items,  ShippingAddress address,  ShippingOption shipping,  String paymentMethod,  double subtotal,  double shippingCost,  double total,  String status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _PlacedOrder():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderNumber,  List<CartItemRef> items,  ShippingAddress address,  ShippingOption shipping,  String paymentMethod,  double subtotal,  double shippingCost,  double total,  String status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PlacedOrder() when $default != null:
return $default(_that.id,_that.orderNumber,_that.items,_that.address,_that.shipping,_that.paymentMethod,_that.subtotal,_that.shippingCost,_that.total,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _PlacedOrder implements PlacedOrder {
  const _PlacedOrder({required this.id, required this.orderNumber, required final  List<CartItemRef> items, required this.address, required this.shipping, required this.paymentMethod, required this.subtotal, required this.shippingCost, required this.total, required this.status, required this.createdAt}): _items = items;
  

@override final  String id;
@override final  String orderNumber;
 final  List<CartItemRef> _items;
@override List<CartItemRef> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  ShippingAddress address;
@override final  ShippingOption shipping;
@override final  String paymentMethod;
@override final  double subtotal;
@override final  double shippingCost;
@override final  double total;
@override final  String status;
@override final  DateTime createdAt;

/// Create a copy of PlacedOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacedOrderCopyWith<_PlacedOrder> get copyWith => __$PlacedOrderCopyWithImpl<_PlacedOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacedOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.address, address) || other.address == address)&&(identical(other.shipping, shipping) || other.shipping == shipping)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.shippingCost, shippingCost) || other.shippingCost == shippingCost)&&(identical(other.total, total) || other.total == total)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,const DeepCollectionEquality().hash(_items),address,shipping,paymentMethod,subtotal,shippingCost,total,status,createdAt);

@override
String toString() {
  return 'PlacedOrder(id: $id, orderNumber: $orderNumber, items: $items, address: $address, shipping: $shipping, paymentMethod: $paymentMethod, subtotal: $subtotal, shippingCost: $shippingCost, total: $total, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PlacedOrderCopyWith<$Res> implements $PlacedOrderCopyWith<$Res> {
  factory _$PlacedOrderCopyWith(_PlacedOrder value, $Res Function(_PlacedOrder) _then) = __$PlacedOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderNumber, List<CartItemRef> items, ShippingAddress address, ShippingOption shipping, String paymentMethod, double subtotal, double shippingCost, double total, String status, DateTime createdAt
});


@override $ShippingAddressCopyWith<$Res> get address;@override $ShippingOptionCopyWith<$Res> get shipping;

}
/// @nodoc
class __$PlacedOrderCopyWithImpl<$Res>
    implements _$PlacedOrderCopyWith<$Res> {
  __$PlacedOrderCopyWithImpl(this._self, this._then);

  final _PlacedOrder _self;
  final $Res Function(_PlacedOrder) _then;

/// Create a copy of PlacedOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNumber = null,Object? items = null,Object? address = null,Object? shipping = null,Object? paymentMethod = null,Object? subtotal = null,Object? shippingCost = null,Object? total = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_PlacedOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemRef>,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as ShippingAddress,shipping: null == shipping ? _self.shipping : shipping // ignore: cast_nullable_to_non_nullable
as ShippingOption,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,shippingCost: null == shippingCost ? _self.shippingCost : shippingCost // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of PlacedOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingAddressCopyWith<$Res> get address {
  
  return $ShippingAddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of PlacedOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingOptionCopyWith<$Res> get shipping {
  
  return $ShippingOptionCopyWith<$Res>(_self.shipping, (value) {
    return _then(_self.copyWith(shipping: value));
  });
}
}

// dart format on
