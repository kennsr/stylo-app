// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderSummaryModel {

 String get id;@JsonKey(name: 'order_number') String get orderNumber;@JsonKey(name: 'item_count') int get itemCount; double get total; String get status;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'first_item_image') String? get firstItemImage;@JsonKey(name: 'first_item_name') String? get firstItemName;
/// Create a copy of OrderSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderSummaryModelCopyWith<OrderSummaryModel> get copyWith => _$OrderSummaryModelCopyWithImpl<OrderSummaryModel>(this as OrderSummaryModel, _$identity);

  /// Serializes this OrderSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount)&&(identical(other.total, total) || other.total == total)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.firstItemImage, firstItemImage) || other.firstItemImage == firstItemImage)&&(identical(other.firstItemName, firstItemName) || other.firstItemName == firstItemName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,itemCount,total,status,createdAt,firstItemImage,firstItemName);

@override
String toString() {
  return 'OrderSummaryModel(id: $id, orderNumber: $orderNumber, itemCount: $itemCount, total: $total, status: $status, createdAt: $createdAt, firstItemImage: $firstItemImage, firstItemName: $firstItemName)';
}


}

/// @nodoc
abstract mixin class $OrderSummaryModelCopyWith<$Res>  {
  factory $OrderSummaryModelCopyWith(OrderSummaryModel value, $Res Function(OrderSummaryModel) _then) = _$OrderSummaryModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'order_number') String orderNumber,@JsonKey(name: 'item_count') int itemCount, double total, String status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'first_item_image') String? firstItemImage,@JsonKey(name: 'first_item_name') String? firstItemName
});




}
/// @nodoc
class _$OrderSummaryModelCopyWithImpl<$Res>
    implements $OrderSummaryModelCopyWith<$Res> {
  _$OrderSummaryModelCopyWithImpl(this._self, this._then);

  final OrderSummaryModel _self;
  final $Res Function(OrderSummaryModel) _then;

/// Create a copy of OrderSummaryModel
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


/// Adds pattern-matching-related methods to [OrderSummaryModel].
extension OrderSummaryModelPatterns on OrderSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _OrderSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _OrderSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'order_number')  String orderNumber, @JsonKey(name: 'item_count')  int itemCount,  double total,  String status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'first_item_image')  String? firstItemImage, @JsonKey(name: 'first_item_name')  String? firstItemName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderSummaryModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'order_number')  String orderNumber, @JsonKey(name: 'item_count')  int itemCount,  double total,  String status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'first_item_image')  String? firstItemImage, @JsonKey(name: 'first_item_name')  String? firstItemName)  $default,) {final _that = this;
switch (_that) {
case _OrderSummaryModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'order_number')  String orderNumber, @JsonKey(name: 'item_count')  int itemCount,  double total,  String status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'first_item_image')  String? firstItemImage, @JsonKey(name: 'first_item_name')  String? firstItemName)?  $default,) {final _that = this;
switch (_that) {
case _OrderSummaryModel() when $default != null:
return $default(_that.id,_that.orderNumber,_that.itemCount,_that.total,_that.status,_that.createdAt,_that.firstItemImage,_that.firstItemName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderSummaryModel implements OrderSummaryModel {
  const _OrderSummaryModel({required this.id, @JsonKey(name: 'order_number') required this.orderNumber, @JsonKey(name: 'item_count') required this.itemCount, required this.total, required this.status, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'first_item_image') this.firstItemImage, @JsonKey(name: 'first_item_name') this.firstItemName});
  factory _OrderSummaryModel.fromJson(Map<String, dynamic> json) => _$OrderSummaryModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'order_number') final  String orderNumber;
@override@JsonKey(name: 'item_count') final  int itemCount;
@override final  double total;
@override final  String status;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'first_item_image') final  String? firstItemImage;
@override@JsonKey(name: 'first_item_name') final  String? firstItemName;

/// Create a copy of OrderSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderSummaryModelCopyWith<_OrderSummaryModel> get copyWith => __$OrderSummaryModelCopyWithImpl<_OrderSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount)&&(identical(other.total, total) || other.total == total)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.firstItemImage, firstItemImage) || other.firstItemImage == firstItemImage)&&(identical(other.firstItemName, firstItemName) || other.firstItemName == firstItemName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,itemCount,total,status,createdAt,firstItemImage,firstItemName);

@override
String toString() {
  return 'OrderSummaryModel(id: $id, orderNumber: $orderNumber, itemCount: $itemCount, total: $total, status: $status, createdAt: $createdAt, firstItemImage: $firstItemImage, firstItemName: $firstItemName)';
}


}

/// @nodoc
abstract mixin class _$OrderSummaryModelCopyWith<$Res> implements $OrderSummaryModelCopyWith<$Res> {
  factory _$OrderSummaryModelCopyWith(_OrderSummaryModel value, $Res Function(_OrderSummaryModel) _then) = __$OrderSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'order_number') String orderNumber,@JsonKey(name: 'item_count') int itemCount, double total, String status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'first_item_image') String? firstItemImage,@JsonKey(name: 'first_item_name') String? firstItemName
});




}
/// @nodoc
class __$OrderSummaryModelCopyWithImpl<$Res>
    implements _$OrderSummaryModelCopyWith<$Res> {
  __$OrderSummaryModelCopyWithImpl(this._self, this._then);

  final _OrderSummaryModel _self;
  final $Res Function(_OrderSummaryModel) _then;

/// Create a copy of OrderSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNumber = null,Object? itemCount = null,Object? total = null,Object? status = null,Object? createdAt = null,Object? firstItemImage = freezed,Object? firstItemName = freezed,}) {
  return _then(_OrderSummaryModel(
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
