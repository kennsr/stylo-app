// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShippingOptionModel _$ShippingOptionModelFromJson(Map<String, dynamic> json) =>
    _ShippingOptionModel(
      id: json['id'] as String,
      courier: json['courier'] as String,
      service: json['service'] as String,
      cost: (json['cost'] as num).toDouble(),
      estimatedDays: (json['estimated_days'] as num).toInt(),
    );

Map<String, dynamic> _$ShippingOptionModelToJson(
  _ShippingOptionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'courier': instance.courier,
  'service': instance.service,
  'cost': instance.cost,
  'estimated_days': instance.estimatedDays,
};
