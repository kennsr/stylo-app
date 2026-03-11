import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/cart_item.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

@freezed
abstract class CartItemModel with _$CartItemModel {
  const factory CartItemModel({
    required String id,
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'product_image') required String productImage,
    required double price,
    required int quantity,
    required String size,
    required String color,
    @JsonKey(name: 'discount_price') double? discountPrice,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);
}

extension CartItemModelX on CartItemModel {
  CartItem toEntity() {
    return CartItem(
      id: id,
      productId: productId,
      productName: productName,
      productImage: productImage,
      price: price,
      quantity: quantity,
      size: size,
      color: color,
      discountPrice: discountPrice,
    );
  }
}

extension CartItemX on CartItem {
  CartItemModel toModel() {
    return CartItemModel(
      id: id,
      productId: productId,
      productName: productName,
      productImage: productImage,
      price: price,
      quantity: quantity,
      size: size,
      color: color,
      discountPrice: discountPrice,
    );
  }
}
