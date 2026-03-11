// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placed_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlacedOrderModel _$PlacedOrderModelFromJson(Map<String, dynamic> json) =>
    _PlacedOrderModel(
      id: json['id'] as String,
      orderNumber: json['order_number'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItemRefModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: ShippingAddressModel.fromJson(
        json['address'] as Map<String, dynamic>,
      ),
      shipping: ShippingOptionModel.fromJson(
        json['shipping'] as Map<String, dynamic>,
      ),
      paymentMethod: json['payment_method'] as String,
      subtotal: (json['subtotal'] as num).toDouble(),
      shippingCost: (json['shipping_cost'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PlacedOrderModelToJson(_PlacedOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'items': instance.items,
      'address': instance.address,
      'shipping': instance.shipping,
      'payment_method': instance.paymentMethod,
      'subtotal': instance.subtotal,
      'shipping_cost': instance.shippingCost,
      'total': instance.total,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
    };
