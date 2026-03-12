import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/entities/shipping_address.dart';
import '../../domain/usecases/get_addresses_usecase.dart';
import '../../domain/usecases/get_payment_methods_usecase.dart';
import '../../domain/usecases/get_shipping_options_usecase.dart';
import '../../domain/usecases/place_order_usecase.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final GetAddressesUseCase getAddressesUseCase;
  final GetShippingOptionsUseCase getShippingOptionsUseCase;
  final GetPaymentMethodsUseCase getPaymentMethodsUseCase;
  final PlaceOrderUseCase placeOrderUseCase;

  CheckoutBloc({
    required this.getAddressesUseCase,
    required this.getShippingOptionsUseCase,
    required this.getPaymentMethodsUseCase,
    required this.placeOrderUseCase,
  }) : super(const CheckoutInitial()) {
    on<CheckoutInitialize>(_onInitialize);
    on<CheckoutSelectAddress>(_onSelectAddress);
    on<CheckoutLoadShipping>(_onLoadShipping);
    on<CheckoutSelectShipping>(_onSelectShipping);
    on<CheckoutSelectPayment>(_onSelectPayment);
    on<CheckoutPlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onInitialize(
    CheckoutInitialize event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(const CheckoutLoading());

    // Load addresses and payment methods in parallel
    final addressResultFuture = getAddressesUseCase(const NoParams());
    final paymentResultFuture = getPaymentMethodsUseCase(const NoParams());

    final addressResult = await addressResultFuture;
    final paymentResult = await paymentResultFuture;

    // Handle address failure (fatal)
    Failure? addressFailure;
    addressResult.fold((f) => addressFailure = f, (_) {});
    if (addressFailure != null) {
      emit(CheckoutError(message: addressFailure!.message));
      return;
    }

    final addresses = addressResult.fold((_) => <ShippingAddress>[], (v) => v);

    // Payment methods failure is non-fatal — use empty list
    final paymentMethods = paymentResult.fold(
      (_) => <PaymentMethod>[],
      (v) => v,
    );

    final defaultAddress = addresses.where((a) => a.isDefault).isNotEmpty
        ? addresses.firstWhere((a) => a.isDefault)
        : addresses.isNotEmpty
            ? addresses.first
            : null;

    emit(CheckoutAddressesLoaded(
      addresses: addresses,
      selectedAddressId: defaultAddress?.id,
      paymentMethods: paymentMethods,
    ));

    if (defaultAddress != null) {
      add(CheckoutLoadShipping(addressId: defaultAddress.id));
    }
  }

  Future<void> _onSelectAddress(
    CheckoutSelectAddress event,
    Emitter<CheckoutState> emit,
  ) async {
    final currentState = state;
    List addresses = [];
    List<PaymentMethod> paymentMethods = [];

    if (currentState is CheckoutAddressesLoaded) {
      addresses = currentState.addresses;
      paymentMethods = currentState.paymentMethods;
    } else if (currentState is CheckoutShippingLoaded) {
      addresses = currentState.addresses;
      paymentMethods = currentState.paymentMethods;
    } else if (currentState is CheckoutReady) {
      addresses = currentState.addresses;
      paymentMethods = currentState.paymentMethods;
    }

    emit(CheckoutAddressesLoaded(
      addresses: List.from(addresses),
      selectedAddressId: event.addressId,
      paymentMethods: paymentMethods,
    ));

    add(CheckoutLoadShipping(addressId: event.addressId));
  }

  Future<void> _onLoadShipping(
    CheckoutLoadShipping event,
    Emitter<CheckoutState> emit,
  ) async {
    final currentState = state;
    List addresses = [];
    List<PaymentMethod> paymentMethods = [];

    if (currentState is CheckoutAddressesLoaded) {
      addresses = currentState.addresses;
      paymentMethods = currentState.paymentMethods;
    } else if (currentState is CheckoutShippingLoaded) {
      addresses = currentState.addresses;
      paymentMethods = currentState.paymentMethods;
    }

    emit(const CheckoutLoading());

    final result = await getShippingOptionsUseCase(
      GetShippingOptionsParams(
        addressId: event.addressId,
        weight: 1.0,
      ),
    );

    result.fold(
      (failure) => emit(CheckoutError(message: failure.message)),
      (options) => emit(CheckoutShippingLoaded(
        addresses: List.from(addresses),
        selectedAddressId: event.addressId,
        options: options,
        paymentMethods: paymentMethods,
      )),
    );
  }

  Future<void> _onSelectShipping(
    CheckoutSelectShipping event,
    Emitter<CheckoutState> emit,
  ) async {
    final currentState = state;
    if (currentState is CheckoutShippingLoaded) {
      emit(CheckoutShippingLoaded(
        addresses: currentState.addresses,
        selectedAddressId: currentState.selectedAddressId,
        options: currentState.options,
        selectedOption: event.option,
        paymentMethods: currentState.paymentMethods,
      ));
    } else if (currentState is CheckoutReady) {
      emit(CheckoutReady(
        addresses: currentState.addresses,
        selectedAddressId: currentState.selectedAddressId,
        shippingOptions: currentState.shippingOptions,
        selectedShipping: event.option,
        selectedPayment: currentState.selectedPayment,
        paymentMethods: currentState.paymentMethods,
      ));
    }
  }

  Future<void> _onSelectPayment(
    CheckoutSelectPayment event,
    Emitter<CheckoutState> emit,
  ) async {
    final currentState = state;
    if (currentState is CheckoutShippingLoaded &&
        currentState.selectedOption != null &&
        currentState.selectedAddressId != null) {
      emit(CheckoutReady(
        addresses: currentState.addresses,
        selectedAddressId: currentState.selectedAddressId!,
        shippingOptions: currentState.options,
        selectedShipping: currentState.selectedOption!,
        selectedPayment: event.method,
        paymentMethods: currentState.paymentMethods,
      ));
    } else if (currentState is CheckoutReady) {
      emit(CheckoutReady(
        addresses: currentState.addresses,
        selectedAddressId: currentState.selectedAddressId,
        shippingOptions: currentState.shippingOptions,
        selectedShipping: currentState.selectedShipping,
        selectedPayment: event.method,
        paymentMethods: currentState.paymentMethods,
      ));
    }
  }

  Future<void> _onPlaceOrder(
    CheckoutPlaceOrder event,
    Emitter<CheckoutState> emit,
  ) async {
    final currentState = state;
    if (currentState is! CheckoutReady) return;

    emit(const CheckoutProcessing());

    final result = await placeOrderUseCase(
      PlaceOrderParams(
        addressId: currentState.selectedAddressId,
        shippingOptionId: currentState.selectedShipping.id,
        paymentMethod: currentState.selectedPayment,
      ),
    );

    result.fold(
      (failure) => emit(CheckoutError(message: failure.message)),
      (order) => emit(CheckoutSuccess(order: order)),
    );
  }
}
