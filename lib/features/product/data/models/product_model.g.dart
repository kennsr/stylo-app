// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(
  Map<String, dynamic> json,
) => _ProductModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  price: (json['price'] as num).toDouble(),
  discountPrice: (json['discount_price'] as num?)?.toDouble(),
  category: json['category'] as String? ?? '',
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  variants:
      (json['variants'] as List<dynamic>?)
          ?.map((e) => ProductVariantModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
  stock: (json['stock'] as num?)?.toInt() ?? 0,
  isFeatured: json['is_featured'] as bool? ?? false,
  hasAiTryOn: json['has_ai_try_on'] as bool? ?? false,
);

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'discount_price': instance.discountPrice,
      'category': instance.category,
      'images': instance.images,
      'variants': instance.variants,
      'rating': instance.rating,
      'review_count': instance.reviewCount,
      'stock': instance.stock,
      'is_featured': instance.isFeatured,
      'has_ai_try_on': instance.hasAiTryOn,
    };
