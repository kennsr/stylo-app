import 'package:equatable/equatable.dart';

enum ProductSortOption {
  terbaru,
  ratingTertinggi,
  hargaTerendah,
  hargaTertinggi,
}

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();
}

class ProductListFetch extends ProductListEvent {
  final String? category;
  final String? search;
  final ProductSortOption sort;
  final double? minPrice;
  final double? maxPrice;

  const ProductListFetch({
    this.category,
    this.search,
    this.sort = ProductSortOption.terbaru,
    this.minPrice,
    this.maxPrice,
  });

  @override
  List<Object?> get props => [category, search, sort, minPrice, maxPrice];
}

class ProductListLoadMore extends ProductListEvent {
  const ProductListLoadMore();

  @override
  List<Object?> get props => [];
}

class ProductListApplyFilter extends ProductListEvent {
  final ProductSortOption sort;
  final double? minPrice;
  final double? maxPrice;

  const ProductListApplyFilter({
    required this.sort,
    this.minPrice,
    this.maxPrice,
  });

  @override
  List<Object?> get props => [sort, minPrice, maxPrice];
}
