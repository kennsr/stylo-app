import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;

  OrdersBloc({required this.getOrdersUseCase}) : super( OrdersInitial()) {
    on<OrdersFetch>(_onFetch);
  }

  Future<void> _onFetch(OrdersFetch event, Emitter<OrdersState> emit) async {
    emit( OrdersLoading());
    final result = await getOrdersUseCase( NoParams());
    result.fold(
      (failure) => emit(OrdersError(message: failure.message)),
      (orders) => emit(OrdersLoaded(orders: orders)),
    );
  }
}
