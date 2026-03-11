import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';
import 'product_variant_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    @JsonKey(name: 'discount_price') double? discountPrice,
    required String category,
    required List<String> images,
    required List<ProductVariantModel> variants,
    required double rating,
    @JsonKey(name: 'review_count') required int reviewCount,
    required int stock,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    @JsonKey(name: 'has_ai_try_on') @Default(false) bool hasAiTryOn,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

extension ProductModelX on ProductModel {
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      discountPrice: discountPrice,
      category: category,
      images: images,
      variants: variants.map((v) => v.toEntity()).toList(),
      rating: rating,
      reviewCount: reviewCount,
      stock: stock,
      isFeatured: isFeatured,
      hasAiTryOn: hasAiTryOn,
    );
  }
}

extension ProductX on Product {
  ProductModel fromEntity() {
    return ProductModel(
      id: id,
      name: name,
      description: description,
      price: price,
      discountPrice: discountPrice,
      category: category,
      images: images,
      variants: variants.map((v) => v.fromEntity()).toList(),
      rating: rating,
      reviewCount: reviewCount,
      stock: stock,
      isFeatured: isFeatured,
      hasAiTryOn: hasAiTryOn,
    );
  }
}
