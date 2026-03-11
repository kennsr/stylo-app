import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class UpdateCartQuantityUseCase
    implements UseCase<Cart, UpdateCartQuantityParams> {
  final CartRepository repository;

  UpdateCartQuantityUseCase(this.repository);

  @override
  Future<Either<Failure, Cart>> call(UpdateCartQuantityParams params) {
    return repository.updateQuantity(params.cartItemId, params.quantity);
  }
}

class UpdateCartQuantityParams extends Equatable {
  final String cartItemId;
  final int quantity;

   const UpdateCartQuantityParams({
    required this.cartItemId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [cartItemId, quantity];
}
