import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_summary.freezed.dart';

@freezed
abstract class ProductSummary with _$ProductSummary {
  const factory ProductSummary({
    required String id,
    required String name,
    required double price,
    String? imageUrl,
    double? discountPrice,
    double? rating,
    required String category,
    @Default(false) bool hasAiTryOn,
  }) = _ProductSummary;
}
