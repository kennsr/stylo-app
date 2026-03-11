import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/entities/cart.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/update_cart_quantity_usecase.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartBloc({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateCartQuantityUseCase,
    required this.clearCartUseCase,
  }) : super( CartInitial()) {
    on<CartFetch>(_onFetch);
    on<CartAddItem>(_onAddItem);
    on<CartRemoveItem>(_onRemoveItem);
    on<CartUpdateQuantity>(_onUpdateQuantity);
    on<CartClear>(_onClear);
  }

  Future<void> _onFetch(CartFetch event, Emitter<CartState> emit) async {
    emit( CartLoading());
    final result = await getCartUseCase( NoParams());
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (cart) => emit(CartLoaded(cart: cart)),
    );
  }

  Future<void> _onAddItem(CartAddItem event, Emitter<CartState> emit) async {
    emit( CartLoading());
    final result = await addToCartUseCase(event.cartItem);
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (cart) => emit(CartLoaded(cart: cart)),
    );
  }

  Future<void> _onRemoveItem(
      CartRemoveItem event, Emitter<CartState> emit) async {
    emit( CartLoading());
    final result = await removeFromCartUseCase(
      RemoveFromCartParams(cartItemId: event.cartItemId),
    );
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (cart) => emit(CartLoaded(cart: cart)),
    );
  }

  Future<void> _onUpdateQuantity(
      CartUpdateQuantity event, Emitter<CartState> emit) async {
    emit( CartLoading());
    final result = await updateCartQuantityUseCase(
      UpdateCartQuantityParams(
        cartItemId: event.cartItemId,
        quantity: event.quantity,
      ),
    );
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (cart) => emit(CartLoaded(cart: cart)),
    );
  }

  Future<void> _onClear(CartClear event, Emitter<CartState> emit) async {
    emit( CartLoading());
    final result = await clearCartUseCase( NoParams());
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (_) => emit( CartLoaded(cart: Cart())),
    );
  }
}
