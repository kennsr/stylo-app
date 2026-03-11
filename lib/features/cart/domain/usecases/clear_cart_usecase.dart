import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/cart_repository.dart';

class ClearCartUseCase implements UseCase<void, NoParams> {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.clearCart();
  }
}
