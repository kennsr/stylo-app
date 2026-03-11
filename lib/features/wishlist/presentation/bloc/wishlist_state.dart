import 'package:equatable/equatable.dart';
import '../../domain/entities/wishlist_product.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();

  @override
  List<Object?> get props => [];
}

class WishlistLoaded extends WishlistState {
  final List<WishlistProduct> items;

  const WishlistLoaded(this.items);

  Set<String> get ids => items.map((p) => p.id).toSet();

  bool isWishlisted(String productId) => ids.contains(productId);

  @override
  List<Object?> get props => [items];
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError(this.message);

  @override
  List<Object?> get props => [message];
}
