import 'package:freezed_annotation/freezed_annotation.dart';
import 'product.dart';

part 'product_list_result.freezed.dart';

@freezed
abstract class ProductListResult with _$ProductListResult {
  const factory ProductListResult({
    required List<Product> products,
    required int totalProducts,
  }) = _ProductListResult;
}
