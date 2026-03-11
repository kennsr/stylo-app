import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';

abstract class ProductDetailState extends Equatable {
   const ProductDetailState();
}

class ProductDetailInitial extends ProductDetailState {
   const ProductDetailInitial();

  @override
  List<Object?> get props => [];
}

class ProductDetailLoading extends ProductDetailState {
   const ProductDetailLoading();

  @override
  List<Object?> get props => [];
}

class ProductDetailLoaded extends ProductDetailState {
  final Product product;
  final List<Review> reviews;

   const ProductDetailLoaded({
    required this.product,
    required this.reviews,
  });

  @override
  List<Object?> get props => [product, reviews];
}

class ProductDetailError extends ProductDetailState {
  final String message;

   const ProductDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
