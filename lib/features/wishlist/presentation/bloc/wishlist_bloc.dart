import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/entities/wishlist_product.dart';
import '../../domain/usecases/get_wishlist_usecase.dart';
import '../../domain/usecases/toggle_wishlist_usecase.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetWishlistUseCase getWishlistUseCase;
  final ToggleWishlistUseCase toggleWishlistUseCase;

  WishlistBloc({
    required this.getWishlistUseCase,
    required this.toggleWishlistUseCase,
  }) : super(const WishlistInitial()) {
    on<WishlistLoad>(_onLoad);
    on<WishlistToggle>(_onToggle);
  }

  Future<void> _onLoad(
    WishlistLoad event,
    Emitter<WishlistState> emit,
  ) async {
    final result = await getWishlistUseCase(const NoParams());
    result.fold(
      (failure) => emit(WishlistError(failure.message)),
      (items) => emit(WishlistLoaded(items)),
    );
  }

  Future<void> _onToggle(
    WishlistToggle event,
    Emitter<WishlistState> emit,
  ) async {
    // Optimistic update
    final currentItems = state is WishlistLoaded
        ? List<WishlistProduct>.from((state as WishlistLoaded).items)
        : <WishlistProduct>[];

    final isCurrentlyLiked = state is WishlistLoaded
        ? (state as WishlistLoaded).isWishlisted(event.product.id)
        : false;

    if (isCurrentlyLiked) {
      final updated =
          currentItems.where((p) => p.id != event.product.id).toList();
      emit(WishlistLoaded(updated));
    } else {
      emit(WishlistLoaded([...currentItems, event.product]));
    }

    // Persist in background
    await toggleWishlistUseCase(event.product);
  }
}
