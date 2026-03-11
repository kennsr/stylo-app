import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/order_detail.dart';
import '../entities/order_summary.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderSummary>>> getOrders();
  Future<Either<Failure, OrderDetail>> getOrderDetail(String orderId);
}
