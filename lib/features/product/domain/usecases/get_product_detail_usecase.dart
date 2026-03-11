import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductDetailParams extends Equatable {
  final String productId;

   const GetProductDetailParams({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class GetProductDetailUseCase
    extends UseCase<Product, GetProductDetailParams> {
  final ProductRepository repository;

  GetProductDetailUseCase({required this.repository});

  @override
  Future<Either<Failure, Product>> call(GetProductDetailParams params) {
    return repository.getProductDetail(params.productId);
  }
}
