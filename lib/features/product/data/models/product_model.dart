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
    // Give safe defaults to fields a real server may omit or return as null.
    // Without @Default, a missing/null JSON field throws TypeError inside
    // fromJson, which propagates past the repository's specific catch clauses
    // and leaves the ProductDetailBloc stuck at ProductDetailLoading forever.
    @Default('') String description,
    required double price,
    @JsonKey(name: 'discount_price') double? discountPrice,
    @Default('') String category,
    @Default([]) List<String> images,
    @Default([]) List<ProductVariantModel> variants,
    @Default(0.0) double rating,
    @JsonKey(name: 'review_count') @Default(0) int reviewCount,
    @Default(0) int stock,
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
