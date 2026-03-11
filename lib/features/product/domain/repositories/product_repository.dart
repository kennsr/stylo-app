import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/product.dart';
import '../entities/review.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    String? category,
    String? search,
    int page = 1,
    int pageSize = 20,
  });

  Future<Either<Failure, Product>> getProductDetail(String productId);

  Future<Either<Failure, List<Product>>> searchProducts(String query);

  Future<Either<Failure, List<Review>>> getReviews(String productId);
}
