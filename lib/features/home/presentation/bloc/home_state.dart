import 'package:equatable/equatable.dart';
import '../../domain/entities/banner.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product_summary.dart';

abstract class HomeState extends Equatable {
   const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
   const HomeInitial();
}

class HomeLoading extends HomeState {
   const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Banner> banners;
  final List<Category> categories;
  final List<ProductSummary> featuredProducts;

   const HomeLoaded({
    required this.banners,
    required this.categories,
    required this.featuredProducts,
  });

  @override
  List<Object?> get props => [banners, categories, featuredProducts];
}

class HomeError extends HomeState {
  final String message;

   const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
