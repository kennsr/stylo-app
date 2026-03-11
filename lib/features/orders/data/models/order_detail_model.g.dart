// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    _OrderItemModel(
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      size: json['size'] as String,
      color: json['color'] as String,
      productImage: json['product_image'] as String?,
    );

Map<String, dynamic> _$OrderItemModelToJson(_OrderItemModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name': instance.productName,
      'quantity': instance.quantity,
      'price': instance.price,
      'size': instance.size,
      'color': instance.color,
      'product_image': instance.productImage,
    };

_OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) =>
    _OrderDetailModel(
      id: json['id'] as String,
      orderNumber: json['order_number'] as String,
      status: json['status'] as String,
      subtotal: (json['subtotal'] as num).toDouble(),
      shippingCost: (json['shipping_cost'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      paymentMethod: json['payment_method'] as String,
      shippingCourier: json['shipping_courier'] as String,
      shippingService: json['shipping_service'] as String,
      receiverName: json['receiver_name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OrderDetailModelToJson(_OrderDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'status': instance.status,
      'subtotal': instance.subtotal,
      'shipping_cost': instance.shippingCost,
      'total': instance.total,
      'payment_method': instance.paymentMethod,
      'shipping_courier': instance.shippingCourier,
      'shipping_service': instance.shippingService,
      'receiver_name': instance.receiverName,
      'address': instance.address,
      'phone': instance.phone,
      'created_at': instance.createdAt.toIso8601String(),
      'items': instance.items,
    };
