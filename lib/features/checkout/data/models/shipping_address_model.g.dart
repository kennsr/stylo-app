// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShippingAddressModel _$ShippingAddressModelFromJson(
  Map<String, dynamic> json,
) => _ShippingAddressModel(
  id: json['id'] as String,
  receiverName: json['receiver_name'] as String,
  phone: json['phone'] as String,
  street: json['street'] as String,
  city: json['city'] as String,
  province: json['province'] as String,
  postalCode: json['postal_code'] as String,
  isDefault: json['is_default'] as bool? ?? false,
  label: json['label'] as String?,
);

Map<String, dynamic> _$ShippingAddressModelToJson(
  _ShippingAddressModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'receiver_name': instance.receiverName,
  'phone': instance.phone,
  'street': instance.street,
  'city': instance.city,
  'province': instance.province,
  'postal_code': instance.postalCode,
  'is_default': instance.isDefault,
  'label': instance.label,
};
