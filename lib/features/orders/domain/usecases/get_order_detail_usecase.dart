import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/order_detail.dart';
import '../repositories/orders_repository.dart';

class GetOrderDetailUseCase
    implements UseCase<OrderDetail, GetOrderDetailParams> {
  final OrdersRepository repository;

  GetOrderDetailUseCase(this.repository);

  @override
  Future<Either<Failure, OrderDetail>> call(GetOrderDetailParams params) {
    return repository.getOrderDetail(params.orderId);
  }
}

class GetOrderDetailParams extends Equatable {
  final String orderId;

   const GetOrderDetailParams({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}
