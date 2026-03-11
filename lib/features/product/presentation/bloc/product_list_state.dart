import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

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
  final bool hasMore;
  final int currentPage;

   const ProductListLoaded({
    required this.products,
    this.hasMore = false,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [products, hasMore, currentPage];
}

class ProductListError extends ProductListState {
  final String message;

   const ProductListError({required this.message});

  @override
  List<Object?> get props => [message];
}
