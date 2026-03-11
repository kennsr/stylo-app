import 'package:freezed_annotation/freezed_annotation.dart';
import 'product_variant.dart';

part 'product.freezed.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String description,
    required double price,
    double? discountPrice,
    required String category,
    required List<String> images,
    required List<ProductVariant> variants,
    required double rating,
    required int reviewCount,
    required int stock,
    @Default(false) bool isFeatured,
    @Default(false) bool hasAiTryOn,
  }) = _Product;
}
