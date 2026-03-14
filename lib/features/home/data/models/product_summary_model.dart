import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product_summary.dart';

part 'product_summary_model.freezed.dart';
part 'product_summary_model.g.dart';

@freezed
abstract class ProductSummaryModel with _$ProductSummaryModel {
  const ProductSummaryModel._();

  const factory ProductSummaryModel({
    required String id,
    required String name,
    required double price,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'images') List<dynamic>? images,
    @JsonKey(name: 'discount_price') double? discountPrice,
    double? rating,
    @JsonKey(name: 'review_count') int? reviewCount,
    required String category,
    @Default(false) @JsonKey(name: 'has_ai_try_on') bool hasAiTryOn,
  }) = _ProductSummaryModel;

  factory ProductSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSummaryModelFromJson(json);

  ProductSummary toEntity() {
    // Extract first image from images array if image_url is not present
    String? firstImage = imageUrl;
    if (firstImage == null && images != null) {
      // Get first image from array
      if (images!.isNotEmpty) {
        final firstItemImage = images!.first;
        if (firstItemImage is String && firstItemImage.isNotEmpty) {
          firstImage = firstItemImage;
        }
      }
    }
    
    return ProductSummary(
      id: id,
      name: name,
      price: price,
      imageUrl: firstImage,
      discountPrice: discountPrice,
      rating: rating,
      category: category,
      hasAiTryOn: hasAiTryOn,
    );
  }
}
