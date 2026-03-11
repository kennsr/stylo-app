import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class SearchProductsParams extends Equatable {
  final String query;

   const SearchProductsParams({required this.query});

  @override
  List<Object?> get props => [query];
}

class SearchProductsUseCase
    extends UseCase<List<Product>, SearchProductsParams> {
  final ProductRepository repository;

  SearchProductsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call(SearchProductsParams params) {
    return repository.searchProducts(params.query);
  }
}
