import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/shipping_address.dart';
import '../repositories/checkout_repository.dart';

class GetAddressesUseCase
    implements UseCase<List<ShippingAddress>, NoParams> {
  final CheckoutRepository repository;

  GetAddressesUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShippingAddress>>> call(NoParams params) {
    return repository.getAddresses();
  }
}
