import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/cart_item_ref.dart';

part 'cart_item_ref_model.freezed.dart';
part 'cart_item_ref_model.g.dart';

@freezed
abstract class CartItemRefModel with _$CartItemRefModel {
  const factory CartItemRefModel({
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'product_name') required String productName,
    required int quantity,
    required double price,
    required String size,
    required String color,
    @JsonKey(name: 'product_image') String? productImage,
  }) = _CartItemRefModel;

  factory CartItemRefModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemRefModelFromJson(json);
}

extension CartItemRefModelX on CartItemRefModel {
  CartItemRef toEntity() {
    return CartItemRef(
      productId: productId,
      productName: productName,
      quantity: quantity,
      price: price,
      size: size,
      color: color,
      productImage: productImage,
    );
  }
}
