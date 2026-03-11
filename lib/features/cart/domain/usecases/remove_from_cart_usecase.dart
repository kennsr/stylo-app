import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase implements UseCase<Cart, RemoveFromCartParams> {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  @override
  Future<Either<Failure, Cart>> call(RemoveFromCartParams params) {
    return repository.removeFromCart(params.cartItemId);
  }
}

class RemoveFromCartParams extends Equatable {
  final String cartItemId;

   const RemoveFromCartParams({required this.cartItemId});

  @override
  List<Object?> get props => [cartItemId];
}
