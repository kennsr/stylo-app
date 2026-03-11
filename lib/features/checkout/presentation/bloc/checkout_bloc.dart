import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/usecases/get_addresses_usecase.dart';
import '../../domain/usecases/get_shipping_options_usecase.dart';
import '../../domain/usecases/place_order_usecase.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final GetAddressesUseCase getAddressesUseCase;
  final GetShippingOptionsUseCase getShippingOptionsUseCase;
  final PlaceOrderUseCase placeOrderUseCase;

  CheckoutBloc({
    required this.getAddressesUseCase,
    required this.getShippingOptionsUseCase,
    required this.placeOrderUseCase,
  }) : super( CheckoutInitial()) {
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
    emit( CheckoutLoading());
    final result = await getAddressesUseCase( NoParams());
    result.fold(
      (failure) => emit(CheckoutError(message: failure.message)),
      (addresses) {
        final defaultAddress = addresses.where((a) => a.isDefault).isNotEmpty
            ? addresses.firstWhere((a) => a.isDefault)
            : addresses.isNotEmpty
                ? addresses.first
                : null;
        emit(CheckoutAddressesLoaded(
          addresses: addresses,
          selectedAddressId: defaultAddress?.id,
        ));
      },
    );
  }

  Future<void> _onSelectAddress(
    CheckoutSelectAddress event,
    Emitter<CheckoutState> emit,
  ) async {
    final currentState = state;
    List addresses = [];
    if (currentState is CheckoutAddressesLoaded) {
      addresses = currentState.addresses;
    } else if (currentState is CheckoutShippingLoaded) {
      addresses = currentState.addresses;
    } else if (currentState is CheckoutReady) {
      addresses = currentState.addresses;
    }

    emit(CheckoutAddressesLoaded(
      addresses: List.from(addresses),
      selectedAddressId: event.addressId,
    ));

    add(CheckoutLoadShipping(addressId: event.addressId));
  }

  Future<void> _onLoadShipping(
    CheckoutLoadShipping event,
    Emitter<CheckoutState> emit,
  ) async {
    final currentState = state;
    List addresses = [];
    if (currentState is CheckoutAddressesLoaded) {
      addresses = currentState.addresses;
    } else if (currentState is CheckoutShippingLoaded) {
      addresses = currentState.addresses;
    }

    emit(CheckoutLoading());

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
      ));
    } else if (currentState is CheckoutReady) {
      emit(CheckoutReady(
        addresses: currentState.addresses,
        selectedAddressId: currentState.selectedAddressId,
        shippingOptions: currentState.shippingOptions,
        selectedShipping: event.option,
        selectedPayment: currentState.selectedPayment,
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
      ));
    } else if (currentState is CheckoutReady) {
      emit(CheckoutReady(
        addresses: currentState.addresses,
        selectedAddressId: currentState.selectedAddressId,
        shippingOptions: currentState.shippingOptions,
        selectedShipping: currentState.selectedShipping,
        selectedPayment: event.method,
      ));
    }
  }

  Future<void> _onPlaceOrder(
    CheckoutPlaceOrder event,
    Emitter<CheckoutState> emit,
  ) async {
    final currentState = state;
    if (currentState is! CheckoutReady) return;

    emit( CheckoutProcessing());

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
