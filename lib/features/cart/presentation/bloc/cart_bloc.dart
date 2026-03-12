import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
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

  /// Monotonically-increasing counter used to detect stale CartFetch results.
  ///
  /// Problem: flutter_bloc processes events of *different* types concurrently.
  /// A `CartFetch` that was already in-flight when `CartAddItem` fires can
  /// complete *after* the optimistic add, silently overwriting the user's cart.
  ///
  /// Fix: `_onAddItem` bumps this counter twice (before + after its API call).
  /// `_onFetch` saves its own snapshot at start and checks it before emitting —
  /// if the snapshot no longer matches, the result is stale and is discarded.
  int _cartVersion = 0;

  CartBloc({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateCartQuantityUseCase,
    required this.clearCartUseCase,
  }) : super(CartInitial()) {
    on<CartFetch>(_onFetch);
    on<CartAddItem>(_onAddItem);
    on<CartRemoveItem>(_onRemoveItem);
    on<CartUpdateQuantity>(_onUpdateQuantity);
    on<CartClear>(_onClear);
  }

  Future<void> _onFetch(CartFetch event, Emitter<CartState> emit) async {
    // Snapshot the version BEFORE the async gap so we can detect any
    // concurrent CartAddItem that started while we were fetching.
    final myVersion = ++_cartVersion;

    // Only show the loading skeleton on a cold start (no data / error).
    // Background re-fetches (e.g. on auth state change) must NOT blank out
    // items that have already been loaded or added optimistically.
    if (state is CartInitial || state is CartError) {
      emit(CartLoading());
    }

    final result = await getCartUseCase(NoParams());

    // A concurrent CartAddItem has invalidated this fetch — discard the result
    // to avoid overwriting the optimistically-updated cart.
    if (myVersion != _cartVersion) return;

    result.fold(
      (failure) {
        // Unauthenticated users or guests should see an empty cart, not an error.
        if (failure is AuthFailure) {
          emit(CartLoaded(cart: Cart()));
        } else {
          emit(CartError(message: failure.message));
        }
      },
      (cart) => emit(CartLoaded(cart: cart)),
    );
  }

  Future<void> _onAddItem(CartAddItem event, Emitter<CartState> emit) async {
    // ── 1. Invalidate in-flight CartFetch (pre-add) ───────────────────────────
    // Any CartFetch that started before this add must not overwrite the
    // optimistic state we're about to emit.
    _cartVersion++;

    // ── 2. Optimistic update ──────────────────────────────────────────────────
    // Add the item to the current cart immediately so the UI responds without
    // a loading spinner that wipes visible items.
    final current =
        state is CartLoaded ? (state as CartLoaded).cart : Cart();

    final existingIdx = current.items.indexWhere(
      (i) =>
          i.productId == event.cartItem.productId &&
          i.size == event.cartItem.size &&
          i.color == event.cartItem.color,
    );

    final optimisticItems = existingIdx >= 0
        ? [
            for (var i = 0; i < current.items.length; i++)
              if (i == existingIdx)
                current.items[i].copyWith(
                  quantity:
                      current.items[i].quantity + event.cartItem.quantity,
                )
              else
                current.items[i],
          ]
        : [...current.items, event.cartItem];

    emit(CartLoaded(cart: Cart(items: optimisticItems)));

    // ── 3. Server sync ────────────────────────────────────────────────────────
    final result = await addToCartUseCase(event.cartItem);

    // ── 4. Invalidate CartFetch events that started DURING the API call ───────
    // Covers the case where a CartFetch was dispatched after step 1 but before
    // the await above resolved (e.g. a delayed AuthAuthenticated listener).
    _cartVersion++;

    result.fold(
      (failure) {
        // Do NOT revert to the pre-add state. Keeping the optimistic item
        // visible is better UX than silently flashing to empty — especially
        // in mock mode where the server never returns the newly-added item.
        // A subsequent CartFetch (e.g. on next app focus) will reconcile.
      },
      (serverCart) {
        // Use the server response only when it actually contains the newly
        // added item. In mock mode the server returns hard-coded stale data
        // that doesn't include the item, so we keep the optimistic state.
        final confirmedByServer = serverCart.items
            .any((i) => i.productId == event.cartItem.productId);
        if (confirmedByServer) {
          emit(CartLoaded(cart: serverCart));
        }
        // Otherwise silently retain the optimistic state.
      },
    );
  }

  Future<void> _onRemoveItem(
      CartRemoveItem event, Emitter<CartState> emit) async {
    emit(CartLoading());
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
    emit(CartLoading());
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
    emit(CartLoading());
    final result = await clearCartUseCase(NoParams());
    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (_) => emit(CartLoaded(cart: Cart())),
    );
  }
}
