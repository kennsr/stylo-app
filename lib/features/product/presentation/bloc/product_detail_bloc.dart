import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../../domain/usecases/get_product_detail_usecase.dart';
import '../../domain/usecases/get_reviews_usecase.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductDetailUseCase getProductDetailUseCase;
  final GetReviewsUseCase getReviewsUseCase;

  ProductDetailBloc({
    required this.getProductDetailUseCase,
    required this.getReviewsUseCase,
  }) : super( ProductDetailInitial()) {
    on<ProductDetailFetch>(_onFetch);
  }

  Future<void> _onFetch(
    ProductDetailFetch event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());

    try {
      final productFuture = getProductDetailUseCase(
        GetProductDetailParams(productId: event.productId),
      );
      final reviewsFuture = getReviewsUseCase(
        GetReviewsParams(productId: event.productId),
      );

      // Run both requests concurrently. Wrapped in try-catch because
      // Future.wait re-throws if either future throws — any unhandled exception
      // (e.g. a JSON parsing TypeError) would otherwise leave the bloc stuck at
      // ProductDetailLoading with an infinite skeleton on screen.
      final results = await Future.wait([productFuture, reviewsFuture]);

      final productEither = results[0];
      final reviewsEither = results[1];

      Product? product;
      String? errorMessage;

      productEither.fold(
        (failure) => errorMessage = failure.message,
        (p) => product = p as Product,
      );

      if (errorMessage != null) {
        emit(ProductDetailError(message: errorMessage!));
        return;
      }

      List<Review> reviews = [];
      reviewsEither.fold(
        (_) => reviews = [], // reviews failure is non-fatal — still show product
        (r) => reviews = r as List<Review>,
      );

      emit(ProductDetailLoaded(product: product!, reviews: reviews));
    } catch (e) {
      emit(ProductDetailError(message: 'Gagal memuat produk: $e'));
    }
  }
}
