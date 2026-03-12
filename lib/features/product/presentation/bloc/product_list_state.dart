import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';
import 'product_list_event.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();
}

class ProductListInitial extends ProductListState {
  const ProductListInitial();

  @override
  List<Object?> get props => [];
}

class ProductListLoading extends ProductListState {
  const ProductListLoading();

  @override
  List<Object?> get props => [];
}

class ProductListLoaded extends ProductListState {
  final List<Product> products;
  final List<Product> allProducts;
  final int totalProducts;
  final bool hasMore;
  final int currentPage;
  final ProductSortOption currentSort;
  final double? currentMinPrice;
  final double? currentMaxPrice;

  bool get hasActiveFilter =>
      currentSort != ProductSortOption.terbaru ||
      currentMinPrice != null ||
      currentMaxPrice != null;

  int get activeFilterCount {
    int count = 0;
    if (currentSort != ProductSortOption.terbaru) count++;
    if (currentMinPrice != null || currentMaxPrice != null) count++;
    return count;
  }

  const ProductListLoaded({
    required this.products,
    required this.allProducts,
    required this.totalProducts,
    this.hasMore = false,
    this.currentPage = 1,
    this.currentSort = ProductSortOption.terbaru,
    this.currentMinPrice,
    this.currentMaxPrice,
  });

  @override
  List<Object?> get props => [
    products,
    allProducts,
    totalProducts,
    hasMore,
    currentPage,
    currentSort,
    currentMinPrice,
    currentMaxPrice,
  ];

  ProductListLoaded copyWith({
    List<Product>? products,
    List<Product>? allProducts,
    int? totalProducts,
    bool? hasMore,
    int? currentPage,
    ProductSortOption? currentSort,
    double? currentMinPrice,
    double? currentMaxPrice,
  }) {
    return ProductListLoaded(
      products: products ?? this.products,
      allProducts: allProducts ?? this.allProducts,
      totalProducts: totalProducts ?? this.totalProducts,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      currentSort: currentSort ?? this.currentSort,
      currentMinPrice: currentMinPrice ?? this.currentMinPrice,
      currentMaxPrice: currentMaxPrice ?? this.currentMaxPrice,
    );
  }
}

class ProductListError extends ProductListState {
  final String message;

  const ProductListError({required this.message});

  @override
  List<Object?> get props => [message];
}
