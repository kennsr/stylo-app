import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/usecases/get_products_usecase.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductsUseCase getProductsUseCase;

  String? _currentCategory;
  String? _currentSearch;

  ProductListBloc({required this.getProductsUseCase})
      : super( ProductListInitial()) {
    on<ProductListFetch>(_onFetch);
    on<ProductListLoadMore>(_onLoadMore);
  }

  Future<void> _onFetch(
    ProductListFetch event,
    Emitter<ProductListState> emit,
  ) async {
    _currentCategory = event.category;
    _currentSearch = event.search;

    emit( ProductListLoading());

    final result = await getProductsUseCase(
      GetProductsParams(
        category: _currentCategory,
        search: _currentSearch,
        page: 1,
      ),
    );

    result.fold(
      (failure) => emit(ProductListError(message: failure.message)),
      (products) => emit(
        ProductListLoaded(
          products: products,
          hasMore: products.length >= AppConstants.defaultPageSize,
          currentPage: 1,
        ),
      ),
    );
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

    result.fold(
      (failure) => emit(ProductListError(message: failure.message)),
      (newProducts) => emit(
        ProductListLoaded(
          products: [...currentState.products, ...newProducts],
          hasMore: newProducts.length >= AppConstants.defaultPageSize,
          currentPage: nextPage,
        ),
      ),
    );
  }
}
