import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/wishlist_product.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_local_data_source.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistLocalDataSource localDataSource;

  WishlistRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<WishlistProduct>>> getWishlist() async {
    try {
      final items = await localDataSource.getWishlist();
      return Right(items);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addToWishlist(WishlistProduct product) async {
    try {
      await localDataSource.addToWishlist(product);
      return Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWishlist(String productId) async {
    try {
      await localDataSource.removeFromWishlist(productId);
      return Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isWishlisted(String productId) async {
    try {
      final result = await localDataSource.isWishlisted(productId);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
