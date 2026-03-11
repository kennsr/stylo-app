import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

@freezed
abstract class CartItem with _$CartItem {
  const factory CartItem({
    required String id,
    required String productId,
    required String productName,
    required String productImage,
    required double price,
    required int quantity,
    required String size,
    required String color,
    double? discountPrice,
  }) = _CartItem;
}
