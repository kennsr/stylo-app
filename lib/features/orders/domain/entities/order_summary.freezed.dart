// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderSummary {

 String get id; String get orderNumber; int get itemCount; double get total; String get status; DateTime get createdAt; String? get firstItemImage; String? get firstItemName;
/// Create a copy of OrderSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderSummaryCopyWith<OrderSummary> get copyWith => _$OrderSummaryCopyWithImpl<OrderSummary>(this as OrderSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount)&&(identical(other.total, total) || other.total == total)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.firstItemImage, firstItemImage) || other.firstItemImage == firstItemImage)&&(identical(other.firstItemName, firstItemName) || other.firstItemName == firstItemName));
}


@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,itemCount,total,status,createdAt,firstItemImage,firstItemName);

@override
String toString() {
  return 'OrderSummary(id: $id, orderNumber: $orderNumber, itemCount: $itemCount, total: $total, status: $status, createdAt: $createdAt, firstItemImage: $firstItemImage, firstItemName: $firstItemName)';
}


}

/// @nodoc
abstract mixin class $OrderSummaryCopyWith<$Res>  {
  factory $OrderSummaryCopyWith(OrderSummary value, $Res Function(OrderSummary) _then) = _$OrderSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String orderNumber, int itemCount, double total, String status, DateTime createdAt, String? firstItemImage, String? firstItemName
});




}
/// @nodoc
class _$OrderSummaryCopyWithImpl<$Res>
    implements $OrderSummaryCopyWith<$Res> {
  _$OrderSummaryCopyWithImpl(this._self, this._then);

  final OrderSummary _self;
  final $Res Function(OrderSummary) _then;

/// Create a copy of OrderSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNumber = null,Object? itemCount = null,Object? total = null,Object? status = null,Object? createdAt = null,Object? firstItemImage = freezed,Object? firstItemName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,firstItemImage: freezed == firstItemImage ? _self.firstItemImage : firstItemImage // ignore: cast_nullable_to_non_nullable
as String?,firstItemName: freezed == firstItemName ? _self.firstItemName : firstItemName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderSummary].
extension OrderSummaryPatterns on OrderSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderSummary value)  $default,){
final _that = this;
switch (_that) {
case _OrderSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderSummary value)?  $default,){
final _that = this;
switch (_that) {
case _OrderSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderNumber,  int itemCount,  double total,  String status,  DateTime createdAt,  String? firstItemImage,  String? firstItemName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderSummary() when $default != null:
return $default(_that.id,_that.orderNumber,_that.itemCount,_that.total,_that.status,_that.createdAt,_that.firstItemImage,_that.firstItemName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderNumber,  int itemCount,  double total,  String status,  DateTime createdAt,  String? firstItemImage,  String? firstItemName)  $default,) {final _that = this;
switch (_that) {
case _OrderSummary():
return $default(_that.id,_that.orderNumber,_that.itemCount,_that.total,_that.status,_that.createdAt,_that.firstItemImage,_that.firstItemName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderNumber,  int itemCount,  double total,  String status,  DateTime createdAt,  String? firstItemImage,  String? firstItemName)?  $default,) {final _that = this;
switch (_that) {
case _OrderSummary() when $default != null:
return $default(_that.id,_that.orderNumber,_that.itemCount,_that.total,_that.status,_that.createdAt,_that.firstItemImage,_that.firstItemName);case _:
  return null;

}
}

}

/// @nodoc


class _OrderSummary implements OrderSummary {
  const _OrderSummary({required this.id, required this.orderNumber, required this.itemCount, required this.total, required this.status, required this.createdAt, this.firstItemImage, this.firstItemName});
  

@override final  String id;
@override final  String orderNumber;
@override final  int itemCount;
@override final  double total;
@override final  String status;
@override final  DateTime createdAt;
@override final  String? firstItemImage;
@override final  String? firstItemName;

/// Create a copy of OrderSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderSummaryCopyWith<_OrderSummary> get copyWith => __$OrderSummaryCopyWithImpl<_OrderSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount)&&(identical(other.total, total) || other.total == total)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.firstItemImage, firstItemImage) || other.firstItemImage == firstItemImage)&&(identical(other.firstItemName, firstItemName) || other.firstItemName == firstItemName));
}


@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,itemCount,total,status,createdAt,firstItemImage,firstItemName);

@override
String toString() {
  return 'OrderSummary(id: $id, orderNumber: $orderNumber, itemCount: $itemCount, total: $total, status: $status, createdAt: $createdAt, firstItemImage: $firstItemImage, firstItemName: $firstItemName)';
}


}

/// @nodoc
abstract mixin class _$OrderSummaryCopyWith<$Res> implements $OrderSummaryCopyWith<$Res> {
  factory _$OrderSummaryCopyWith(_OrderSummary value, $Res Function(_OrderSummary) _then) = __$OrderSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderNumber, int itemCount, double total, String status, DateTime createdAt, String? firstItemImage, String? firstItemName
});




}
/// @nodoc
class __$OrderSummaryCopyWithImpl<$Res>
    implements _$OrderSummaryCopyWith<$Res> {
  __$OrderSummaryCopyWithImpl(this._self, this._then);

  final _OrderSummary _self;
  final $Res Function(_OrderSummary) _then;

/// Create a copy of OrderSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNumber = null,Object? itemCount = null,Object? total = null,Object? status = null,Object? createdAt = null,Object? firstItemImage = freezed,Object? firstItemName = freezed,}) {
  return _then(_OrderSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,firstItemImage: freezed == firstItemImage ? _self.firstItemImage : firstItemImage // ignore: cast_nullable_to_non_nullable
as String?,firstItemName: freezed == firstItemName ? _self.firstItemName : firstItemName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
