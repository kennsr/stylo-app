import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/cart.dart';
import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> getCart();
  Future<Either<Failure, Cart>> addToCart(CartItem item);
  Future<Either<Failure, Cart>> removeFromCart(String cartItemId);
  Future<Either<Failure, Cart>> updateQuantity(String cartItemId, int quantity);
  Future<Either<Failure, void>> clearCart();
}
