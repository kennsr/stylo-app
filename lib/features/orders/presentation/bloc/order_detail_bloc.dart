import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_order_detail_usecase.dart';
import 'order_detail_event.dart';
import 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final GetOrderDetailUseCase getOrderDetailUseCase;

  OrderDetailBloc({required this.getOrderDetailUseCase})
      : super( OrderDetailInitial()) {
    on<OrderDetailFetch>(_onFetch);
  }

  Future<void> _onFetch(
      OrderDetailFetch event, Emitter<OrderDetailState> emit) async {
    emit( OrderDetailLoading());
    final result = await getOrderDetailUseCase(
      GetOrderDetailParams(orderId: event.orderId),
    );
    result.fold(
      (failure) => emit(OrderDetailError(message: failure.message)),
      (order) => emit(OrderDetailLoaded(order: order)),
    );
  }
}
