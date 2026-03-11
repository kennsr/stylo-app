import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item_ref.freezed.dart';

@freezed
abstract class CartItemRef with _$CartItemRef {
  const factory CartItemRef({
    required String productId,
    required String productName,
    required int quantity,
    required double price,
    required String size,
    required String color,
    String? productImage,
  }) = _CartItemRef;
}
