import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
   const ProductListEvent();
}

class ProductListFetch extends ProductListEvent {
  final String? category;
  final String? search;

   const ProductListFetch({this.category, this.search});

  @override
  List<Object?> get props => [category, search];
}

class ProductListLoadMore extends ProductListEvent {
   const ProductListLoadMore();

  @override
  List<Object?> get props => [];
}
