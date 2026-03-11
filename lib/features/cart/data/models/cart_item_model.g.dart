// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    _CartItemModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      productImage: json['product_image'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      size: json['size'] as String,
      color: json['color'] as String,
      discountPrice: (json['discount_price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartItemModelToJson(_CartItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'product_image': instance.productImage,
      'price': instance.price,
      'quantity': instance.quantity,
      'size': instance.size,
      'color': instance.color,
      'discount_price': instance.discountPrice,
    };
