import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/banner.dart';
import '../entities/category.dart';
import '../entities/product_summary.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Banner>>> getBanners();
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<ProductSummary>>> getFeaturedProducts();
}
