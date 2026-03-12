import 'package:equatable/equatable.dart';
import 'package:stylo/core/errors/failures.dart';
import 'package:stylo/core/utils/either.dart';
import 'package:stylo/core/utils/usecase.dart';
import 'package:stylo/features/product/domain/entities/product_list_result.dart';
import 'package:stylo/features/product/domain/repositories/product_repository.dart';

class GetProductsParams extends Equatable {
  final String? category;
  final String? search;
  final int page;
  final int pageSize;

  const GetProductsParams({
    this.category,
    this.search,
    this.page = 1,
    this.pageSize = 20,
  });

  @override
  List<Object?> get props => [category, search, page, pageSize];
}

class GetProductsUseCase extends UseCase<ProductListResult, GetProductsParams> {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});

  @override
  Future<Either<Failure, ProductListResult>> call(GetProductsParams params) {
    return repository.getProducts(
      category: params.category,
      search: params.search,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}
