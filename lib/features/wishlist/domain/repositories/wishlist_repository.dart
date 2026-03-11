import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/wishlist_product.dart';

abstract class WishlistRepository {
  Future<Either<Failure, List<WishlistProduct>>> getWishlist();
  Future<Either<Failure, void>> addToWishlist(WishlistProduct product);
  Future<Either<Failure, void>> removeFromWishlist(String productId);
  Future<Either<Failure, bool>> isWishlisted(String productId);
}
