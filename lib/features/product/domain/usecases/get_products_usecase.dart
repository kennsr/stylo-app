import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsParams extends Equatable {
  final String? category;
  final String? search;
  final int page;

   const GetProductsParams({
    this.category,
    this.search,
    this.page = 1,
  });

  @override
  List<Object?> get props => [category, search, page];
}

class GetProductsUseCase extends UseCase<List<Product>, GetProductsParams> {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call(GetProductsParams params) {
    return repository.getProducts(
      category: params.category,
      search: params.search,
      page: params.page,
    );
  }
}
