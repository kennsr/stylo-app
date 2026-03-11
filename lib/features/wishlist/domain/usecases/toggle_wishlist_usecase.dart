import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/wishlist_product.dart';
import '../repositories/wishlist_repository.dart';

class ToggleWishlistUseCase {
  final WishlistRepository repository;

  ToggleWishlistUseCase(this.repository);

  Future<Either<Failure, bool>> call(WishlistProduct product) async {
    final isLikedResult = await repository.isWishlisted(product.id);
    return isLikedResult.fold(
      (failure) async => Left(failure),
      (isLiked) async {
        if (isLiked) {
          final result = await repository.removeFromWishlist(product.id);
          return result.map((_) => false);
        } else {
          final result = await repository.addToWishlist(product);
          return result.map((_) => true);
        }
      },
    );
  }
}
