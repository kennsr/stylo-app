import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/cart.dart';
import 'cart_item_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
abstract class CartModel with _$CartModel {
  const factory CartModel({
    @Default([]) List<CartItemModel> items,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}

extension CartModelX on CartModel {
  Cart toEntity() {
    return Cart(
      items: items.map((item) => item.toEntity()).toList(),
    );
  }
}

extension CartX on Cart {
  CartModel toModel() {
    return CartModel(
      items: items.map((item) => item.toModel()).toList(),
    );
  }
}
