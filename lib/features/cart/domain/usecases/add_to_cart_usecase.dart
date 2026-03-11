import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/cart.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase implements UseCase<Cart, CartItem> {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  @override
  Future<Either<Failure, Cart>> call(CartItem params) {
    return repository.addToCart(params);
  }
}
