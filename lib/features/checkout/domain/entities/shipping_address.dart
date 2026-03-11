import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipping_address.freezed.dart';

@freezed
abstract class ShippingAddress with _$ShippingAddress {
  const factory ShippingAddress({
    required String id,
    required String receiverName,
    required String phone,
    required String street,
    required String city,
    required String province,
    required String postalCode,
    @Default(false) bool isDefault,
    String? label,
  }) = _ShippingAddress;
}
