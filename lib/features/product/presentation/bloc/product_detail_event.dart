import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
   const ProductDetailEvent();
}

class ProductDetailFetch extends ProductDetailEvent {
  final String productId;

   const ProductDetailFetch({required this.productId});

  @override
  List<Object?> get props => [productId];
}
