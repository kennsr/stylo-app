import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/payment_method.dart';
import '../repositories/checkout_repository.dart';

class GetPaymentMethodsUseCase
    extends UseCase<List<PaymentMethod>, NoParams> {
  final CheckoutRepository repository;

  GetPaymentMethodsUseCase(this.repository);

  @override
  Future<Either<Failure, List<PaymentMethod>>> call(NoParams params) {
    return repository.getPaymentMethods();
  }
}
