// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderSummaryModel _$OrderSummaryModelFromJson(Map<String, dynamic> json) =>
    _OrderSummaryModel(
      id: json['id'] as String,
      orderNumber: json['order_number'] as String,
      itemCount: (json['item_count'] as num).toInt(),
      total: (json['total'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      firstItemImage: json['first_item_image'] as String?,
      firstItemName: json['first_item_name'] as String?,
    );

Map<String, dynamic> _$OrderSummaryModelToJson(_OrderSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'item_count': instance.itemCount,
      'total': instance.total,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'first_item_image': instance.firstItemImage,
      'first_item_name': instance.firstItemName,
    };
