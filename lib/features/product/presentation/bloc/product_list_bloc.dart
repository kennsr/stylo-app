import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products_usecase.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductsUseCase getProductsUseCase;

  String? _currentCategory;
  String? _currentSearch;
  ProductSortOption _currentSort = ProductSortOption.terbaru;
  double? _currentMinPrice;
  double? _currentMaxPrice;

  ProductListBloc({required this.getProductsUseCase})
    : super(const ProductListInitial()) {
    on<ProductListFetch>(_onFetch);
    on<ProductListLoadMore>(_onLoadMore);
    on<ProductListApplyFilter>(_onApplyFilter);
  }

  Future<void> _onFetch(
    ProductListFetch event,
    Emitter<ProductListState> emit,
  ) async {
    _currentCategory = event.category;
    _currentSearch = event.search;
    _currentSort = event.sort;
    _currentMinPrice = event.minPrice;
    _currentMaxPrice = event.maxPrice;

    emit(const ProductListLoading());

    final result = await getProductsUseCase(
      GetProductsParams(
        category: _currentCategory,
        search: _currentSearch,
        page: 1,
      ),
    );

    result.fold((failure) => emit(ProductListError(message: failure.message)), (
      result,
    ) {
      final filtered = _applySortAndFilter(
        result.products,
        _currentSort,
        _currentMinPrice,
        _currentMaxPrice,
      );
      emit(
        ProductListLoaded(
          products: filtered,
          allProducts: result.products,
          totalProducts: result.totalProducts,
          hasMore: result.products.length >= AppConstants.defaultPageSize,
          currentPage: 1,
          currentSort: _currentSort,
          currentMinPrice: _currentMinPrice,
          currentMaxPrice: _currentMaxPrice,
        ),
      );
    });
  }

  Future<void> _onLoadMore(
    ProductListLoadMore event,
    Emitter<ProductListState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ProductListLoaded) return;
    if (!currentState.hasMore) return;

    final nextPage = currentState.currentPage + 1;

    final result = await getProductsUseCase(
      GetProductsParams(
        category: _currentCategory,
        search: _currentSearch,
        page: nextPage,
      ),
    );

    result.fold((failure) => emit(ProductListError(message: failure.message)), (
      result,
    ) {
      final combinedAll = [...currentState.allProducts, ...result.products];
      final filtered = _applySortAndFilter(
        combinedAll,
        _currentSort,
        _currentMinPrice,
        _currentMaxPrice,
      );
      emit(
        currentState.copyWith(
          products: filtered,
          allProducts: combinedAll,
          // Only update total if we got a valid one (on first page or if backend returns it)
          totalProducts: result.totalProducts != -1
              ? result.totalProducts
              : currentState.totalProducts,
          hasMore: result.products.length >= AppConstants.defaultPageSize,
          currentPage: nextPage,
        ),
      );
    });
  }

  void _onApplyFilter(
    ProductListApplyFilter event,
    Emitter<ProductListState> emit,
  ) {
    final currentState = state;
    if (currentState is! ProductListLoaded) return;

    _currentSort = event.sort;
    _currentMinPrice = event.minPrice;
    _currentMaxPrice = event.maxPrice;

    final filtered = _applySortAndFilter(
      currentState.allProducts,
      _currentSort,
      _currentMinPrice,
      _currentMaxPrice,
    );

    emit(
      currentState.copyWith(
        products: filtered,
        currentSort: _currentSort,
        currentMinPrice: _currentMinPrice,
        currentMaxPrice: _currentMaxPrice,
      ),
    );
  }

  List<Product> _applySortAndFilter(
    List<Product> products,
    ProductSortOption sort,
    double? minPrice,
    double? maxPrice,
  ) {
    var result = products.toList();

    // Price filter
    if (minPrice != null) {
      result = result
          .where((p) => (p.discountPrice ?? p.price) >= minPrice)
          .toList();
    }
    if (maxPrice != null) {
      result = result
          .where((p) => (p.discountPrice ?? p.price) <= maxPrice)
          .toList();
    }

    // Sort
    switch (sort) {
      case ProductSortOption.hargaTerendah:
        result.sort(
          (a, b) => (a.discountPrice ?? a.price).compareTo(
            b.discountPrice ?? b.price,
          ),
        );
      case ProductSortOption.hargaTertinggi:
        result.sort(
          (a, b) => (b.discountPrice ?? b.price).compareTo(
            a.discountPrice ?? a.price,
          ),
        );
      case ProductSortOption.ratingTertinggi:
        result.sort((a, b) => b.rating.compareTo(a.rating));
      case ProductSortOption.terbaru:
        break; // keep original order
    }

    return result;
  }
}
