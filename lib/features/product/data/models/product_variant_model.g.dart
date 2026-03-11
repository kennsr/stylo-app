// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductVariantModel _$ProductVariantModelFromJson(Map<String, dynamic> json) =>
    _ProductVariantModel(
      id: json['id'] as String,
      size: json['size'] as String,
      color: json['color'] as String,
      stock: (json['stock'] as num).toInt(),
      additionalPrice: (json['additional_price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductVariantModelToJson(
  _ProductVariantModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'size': instance.size,
  'color': instance.color,
  'stock': instance.stock,
  'additional_price': instance.additionalPrice,
};
