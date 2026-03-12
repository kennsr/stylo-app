import 'package:equatable/equatable.dart';
import '../../domain/entities/wishlist_product.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();
}

class WishlistLoad extends WishlistEvent {
  const WishlistLoad();

  @override
  List<Object?> get props => [];
}

class WishlistToggle extends WishlistEvent {
  final WishlistProduct product;

  const WishlistToggle(this.product);

  @override
  List<Object?> get props => [product.id];
}

/// Clears the in-memory wishlist without touching local storage.
/// Dispatched on logout so the next user's session starts clean.
class WishlistReset extends WishlistEvent {
  const WishlistReset();

  @override
  List<Object?> get props => [];
}
