import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/shipping_option.dart';
import '../repositories/checkout_repository.dart';

class GetShippingOptionsUseCase
    implements UseCase<List<ShippingOption>, GetShippingOptionsParams> {
  final CheckoutRepository repository;

  GetShippingOptionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShippingOption>>> call(
      GetShippingOptionsParams params) {
    return repository.getShippingOptions(
      addressId: params.addressId,
      weight: params.weight,
    );
  }
}

class GetShippingOptionsParams extends Equatable {
  final String addressId;
  final double weight;

   const GetShippingOptionsParams({
    required this.addressId,
    required this.weight,
  });

  @override
  List<Object?> get props => [addressId, weight];
}
