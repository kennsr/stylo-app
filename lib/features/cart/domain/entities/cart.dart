import 'package:freezed_annotation/freezed_annotation.dart';
import 'cart_item.dart';

part 'cart.freezed.dart';

@freezed
abstract class Cart with _$Cart {
  const Cart._();
  const factory Cart({@Default([]) List<CartItem> items}) = _Cart;

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => items.fold(
    0.0,
    (sum, item) => sum + (item.discountPrice ?? item.price) * item.quantity,
  );
}
