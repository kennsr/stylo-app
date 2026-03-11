import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/wishlist_product.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlistUseCase extends UseCase<List<WishlistProduct>, NoParams> {
  final WishlistRepository repository;

  GetWishlistUseCase(this.repository);

  @override
  Future<Either<Failure, List<WishlistProduct>>> call(NoParams params) =>
      repository.getWishlist();
}
