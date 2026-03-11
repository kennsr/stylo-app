import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/product_summary.dart';
import '../repositories/home_repository.dart';

class GetFeaturedProductsUseCase
    extends UseCase<List<ProductSummary>, NoParams> {
  final HomeRepository repository;

  GetFeaturedProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductSummary>>> call(NoParams params) =>
      repository.getFeaturedProducts();
}
