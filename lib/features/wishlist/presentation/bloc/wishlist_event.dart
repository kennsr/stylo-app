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
