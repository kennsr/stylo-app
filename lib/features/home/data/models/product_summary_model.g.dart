// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductSummaryModel _$ProductSummaryModelFromJson(Map<String, dynamic> json) =>
    _ProductSummaryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String?,
      images: json['images'] as List<dynamic>?,
      discountPrice: (json['discount_price'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: (json['review_count'] as num?)?.toInt(),
      category: json['category'] as String,
      hasAiTryOn: json['has_ai_try_on'] as bool? ?? false,
    );

Map<String, dynamic> _$ProductSummaryModelToJson(
  _ProductSummaryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'image_url': instance.imageUrl,
  'images': instance.images,
  'discount_price': instance.discountPrice,
  'rating': instance.rating,
  'review_count': instance.reviewCount,
  'category': instance.category,
  'has_ai_try_on': instance.hasAiTryOn,
};
