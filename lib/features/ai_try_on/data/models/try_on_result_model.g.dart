// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'try_on_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TryOnResultModel _$TryOnResultModelFromJson(Map<String, dynamic> json) =>
    _TryOnResultModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      originalImageUrl: json['original_image_url'] as String,
      resultImageUrl: json['result_image_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      isSaved: json['is_saved'] as bool? ?? false,
    );

Map<String, dynamic> _$TryOnResultModelToJson(_TryOnResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'original_image_url': instance.originalImageUrl,
      'result_image_url': instance.resultImageUrl,
      'created_at': instance.createdAt.toIso8601String(),
      'is_saved': instance.isSaved,
    };
