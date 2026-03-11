import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/placed_order.dart';
import '../repositories/checkout_repository.dart';

class PlaceOrderUseCase implements UseCase<PlacedOrder, PlaceOrderParams> {
  final CheckoutRepository repository;

  PlaceOrderUseCase(this.repository);

  @override
  Future<Either<Failure, PlacedOrder>> call(PlaceOrderParams params) {
    return repository.placeOrder(
      addressId: params.addressId,
      shippingOptionId: params.shippingOptionId,
      paymentMethod: params.paymentMethod,
    );
  }
}

class PlaceOrderParams extends Equatable {
  final String addressId;
  final String shippingOptionId;
  final String paymentMethod;

   const PlaceOrderParams({
    required this.addressId,
    required this.shippingOptionId,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [addressId, shippingOptionId, paymentMethod];
}
