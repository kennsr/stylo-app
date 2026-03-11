import 'package:equatable/equatable.dart';

abstract class OrderDetailEvent extends Equatable {
   const OrderDetailEvent();

  @override
  List<Object?> get props => [];
}

class OrderDetailFetch extends OrderDetailEvent {
  final String orderId;
   const OrderDetailFetch({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}
