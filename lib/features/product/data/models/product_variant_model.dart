import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product_variant.dart';

part 'product_variant_model.freezed.dart';
part 'product_variant_model.g.dart';

@freezed
abstract class ProductVariantModel with _$ProductVariantModel {
  const factory ProductVariantModel({
    required String id,
    required String size,
    required String color,
    required int stock,
    @JsonKey(name: 'additional_price') double? additionalPrice,
  }) = _ProductVariantModel;

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantModelFromJson(json);
}

extension ProductVariantModelX on ProductVariantModel {
  ProductVariant toEntity() {
    return ProductVariant(
      id: id,
      size: size,
      color: color,
      stock: stock,
      additionalPrice: additionalPrice,
    );
  }
}

extension ProductVariantX on ProductVariant {
  ProductVariantModel fromEntity() {
    return ProductVariantModel(
      id: id,
      size: size,
      color: color,
      stock: stock,
      additionalPrice: additionalPrice,
    );
  }
}
