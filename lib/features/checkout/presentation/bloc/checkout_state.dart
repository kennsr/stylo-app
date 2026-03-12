import 'package:equatable/equatable.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/entities/placed_order.dart';
import '../../domain/entities/shipping_address.dart';
import '../../domain/entities/shipping_option.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();
}

class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();
}

class CheckoutAddressesLoaded extends CheckoutState {
  final List<ShippingAddress> addresses;
  final String? selectedAddressId;
  final List<PaymentMethod> paymentMethods;

  const CheckoutAddressesLoaded({
    required this.addresses,
    this.selectedAddressId,
    this.paymentMethods = const [],
  });

  @override
  List<Object?> get props => [addresses, selectedAddressId, paymentMethods];
}

class CheckoutShippingLoaded extends CheckoutState {
  final List<ShippingAddress> addresses;
  final String? selectedAddressId;
  final List<ShippingOption> options;
  final ShippingOption? selectedOption;
  final List<PaymentMethod> paymentMethods;

  const CheckoutShippingLoaded({
    required this.addresses,
    this.selectedAddressId,
    required this.options,
    this.selectedOption,
    this.paymentMethods = const [],
  });

  @override
  List<Object?> get props => [
        addresses,
        selectedAddressId,
        options,
        selectedOption,
        paymentMethods,
      ];
}

class CheckoutReady extends CheckoutState {
  final List<ShippingAddress> addresses;
  final String selectedAddressId;
  final List<ShippingOption> shippingOptions;
  final ShippingOption selectedShipping;
  final String selectedPayment;
  final List<PaymentMethod> paymentMethods;

  const CheckoutReady({
    required this.addresses,
    required this.selectedAddressId,
    required this.shippingOptions,
    required this.selectedShipping,
    required this.selectedPayment,
    this.paymentMethods = const [],
  });

  @override
  List<Object?> get props => [
        addresses,
        selectedAddressId,
        shippingOptions,
        selectedShipping,
        selectedPayment,
        paymentMethods,
      ];
}

class CheckoutProcessing extends CheckoutState {
  const CheckoutProcessing();
}

class CheckoutSuccess extends CheckoutState {
  final PlacedOrder order;
  const CheckoutSuccess({required this.order});

  @override
  List<Object?> get props => [order];
}

class CheckoutError extends CheckoutState {
  final String message;
  const CheckoutError({required this.message});

  @override
  List<Object?> get props => [message];
}
