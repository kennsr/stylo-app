// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_ref_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItemRefModel _$CartItemRefModelFromJson(Map<String, dynamic> json) =>
    _CartItemRefModel(
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      size: json['size'] as String,
      color: json['color'] as String,
      productImage: json['product_image'] as String?,
    );

Map<String, dynamic> _$CartItemRefModelToJson(_CartItemRefModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name': instance.productName,
      'quantity': instance.quantity,
      'price': instance.price,
      'size': instance.size,
      'color': instance.color,
      'product_image': instance.productImage,
    };
