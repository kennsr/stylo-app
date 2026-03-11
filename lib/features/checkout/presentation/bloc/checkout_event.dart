import 'package:equatable/equatable.dart';
import '../../domain/entities/shipping_option.dart';

abstract class CheckoutEvent extends Equatable {
   const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class CheckoutInitialize extends CheckoutEvent {
   const CheckoutInitialize();
}

class CheckoutSelectAddress extends CheckoutEvent {
  final String addressId;
   const CheckoutSelectAddress({required this.addressId});

  @override
  List<Object?> get props => [addressId];
}

class CheckoutLoadShipping extends CheckoutEvent {
  final String addressId;
   const CheckoutLoadShipping({required this.addressId});

  @override
  List<Object?> get props => [addressId];
}

class CheckoutSelectShipping extends CheckoutEvent {
  final ShippingOption option;
   const CheckoutSelectShipping({required this.option});

  @override
  List<Object?> get props => [option];
}

class CheckoutSelectPayment extends CheckoutEvent {
  final String method;
   const CheckoutSelectPayment({required this.method});

  @override
  List<Object?> get props => [method];
}

class CheckoutPlaceOrder extends CheckoutEvent {
   const CheckoutPlaceOrder();
}
