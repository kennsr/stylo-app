import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class GetCartUseCase implements UseCase<Cart, NoParams> {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  @override
  Future<Either<Failure, Cart>> call(NoParams params) {
    return repository.getCart();
  }
}
