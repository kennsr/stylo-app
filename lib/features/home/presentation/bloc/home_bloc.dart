import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/entities/banner.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product_summary.dart';
import '../../domain/usecases/get_banners_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_featured_products_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetBannersUseCase getBannersUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetFeaturedProductsUseCase getFeaturedProductsUseCase;

  HomeBloc({
    required this.getBannersUseCase,
    required this.getCategoriesUseCase,
    required this.getFeaturedProductsUseCase,
  }) : super( HomeInitial()) {
    on<HomeFetchData>(_onFetchData);
  }

  Future<void> _onFetchData(
    HomeFetchData event,
    Emitter<HomeState> emit,
  ) async {
    emit( HomeLoading());
    try {
      final results = await Future.wait([
        getBannersUseCase( NoParams()),
        getCategoriesUseCase( NoParams()),
        getFeaturedProductsUseCase( NoParams()),
      ]);

      final bannersResult = results[0];
      final categoriesResult = results[1];
      final productsResult = results[2];

      List<Banner> banners = [];
      List<Category> categories = [];
      List<ProductSummary> featuredProducts = [];
      String? errorMessage;

      bannersResult.fold(
        (failure) => errorMessage ??= failure.message,
        (data) => banners = data as List<Banner>,
      );

      categoriesResult.fold(
        (failure) => errorMessage ??= failure.message,
        (data) => categories = data as List<Category>,
      );

      productsResult.fold(
        (failure) => errorMessage ??= failure.message,
        (data) => featuredProducts = data as List<ProductSummary>,
      );

      if (errorMessage != null &&
          banners.isEmpty &&
          categories.isEmpty &&
          featuredProducts.isEmpty) {
        emit(HomeError(message: errorMessage!));
      } else {
        emit(HomeLoaded(
          banners: banners,
          categories: categories,
          featuredProducts: featuredProducts,
        ));
      }
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
