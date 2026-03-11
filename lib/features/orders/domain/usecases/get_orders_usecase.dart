import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/order_summary.dart';
import '../repositories/orders_repository.dart';

class GetOrdersUseCase implements UseCase<List<OrderSummary>, NoParams> {
  final OrdersRepository repository;

  GetOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderSummary>>> call(NoParams params) {
    return repository.getOrders();
  }
}
