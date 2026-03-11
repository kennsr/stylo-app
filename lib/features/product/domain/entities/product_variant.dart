import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_variant.freezed.dart';

@freezed
abstract class ProductVariant with _$ProductVariant {
  const factory ProductVariant({
    required String id,
    required String size,
    required String color,
    required int stock,
    double? additionalPrice,
  }) = _ProductVariant;
}
