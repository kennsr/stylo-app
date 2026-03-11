import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipping_option.freezed.dart';

@freezed
abstract class ShippingOption with _$ShippingOption {
  const factory ShippingOption({
    required String id,
    required String courier,
    required String service,
    required double cost,
    required int estimatedDays,
  }) = _ShippingOption;
}
