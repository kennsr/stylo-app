import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/shipping_address.dart';

part 'shipping_address_model.freezed.dart';
part 'shipping_address_model.g.dart';

@freezed
abstract class ShippingAddressModel with _$ShippingAddressModel {
  const factory ShippingAddressModel({
    required String id,
    @JsonKey(name: 'receiver_name') required String receiverName,
    required String phone,
    required String street,
    required String city,
    required String province,
    @JsonKey(name: 'postal_code') required String postalCode,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
    String? label,
  }) = _ShippingAddressModel;

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressModelFromJson(json);
}

extension ShippingAddressModelX on ShippingAddressModel {
  ShippingAddress toEntity() {
    return ShippingAddress(
      id: id,
      receiverName: receiverName,
      phone: phone,
      street: street,
      city: city,
      province: province,
      postalCode: postalCode,
      isDefault: isDefault,
      label: label,
    );
  }
}
