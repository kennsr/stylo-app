import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item.dart';

abstract class CartEvent extends Equatable {
   const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartFetch extends CartEvent {
   const CartFetch();
}

class CartAddItem extends CartEvent {
  final CartItem cartItem;
   const CartAddItem({required this.cartItem});

  @override
  List<Object?> get props => [cartItem];
}

class CartRemoveItem extends CartEvent {
  final String cartItemId;
   const CartRemoveItem({required this.cartItemId});

  @override
  List<Object?> get props => [cartItemId];
}

class CartUpdateQuantity extends CartEvent {
  final String cartItemId;
  final int quantity;
   const CartUpdateQuantity({required this.cartItemId, required this.quantity});

  @override
  List<Object?> get props => [cartItemId, quantity];
}

class CartClear extends CartEvent {
   const CartClear();
}
