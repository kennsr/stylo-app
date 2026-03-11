import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/shipping_option.dart';

part 'shipping_option_model.freezed.dart';
part 'shipping_option_model.g.dart';

@freezed
abstract class ShippingOptionModel with _$ShippingOptionModel {
  const factory ShippingOptionModel({
    required String id,
    required String courier,
    required String service,
    required double cost,
    @JsonKey(name: 'estimated_days') required int estimatedDays,
  }) = _ShippingOptionModel;

  factory ShippingOptionModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingOptionModelFromJson(json);
}

extension ShippingOptionModelX on ShippingOptionModel {
  ShippingOption toEntity() {
    return ShippingOption(
      id: id,
      courier: courier,
      service: service,
      cost: cost,
      estimatedDays: estimatedDays,
    );
  }
}
