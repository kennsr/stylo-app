import '../../../../core/constants/env_config.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/wishlist_product.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_local_data_source.dart';
import '../datasources/wishlist_remote_data_source.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistLocalDataSource localDataSource;
  final WishlistRemoteDataSource remoteDataSource;

  WishlistRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<WishlistProduct>>> getWishlist() async {
    try {
      final localItems = await localDataSource.getWishlist();

      if (!EnvConfig.useMock) {
        // Non-mock: reconcile local cache with server state.
        // Server is the source of truth for WHICH items are wishlisted.
        // Local cache is the source of truth for PRODUCT DISPLAY DATA.
        try {
          final serverIds = await remoteDataSource.getWishlistedIds();
          final serverIdSet = serverIds.toSet();

          // Keep only items that the server confirms are still wishlisted
          final synced =
              localItems.where((p) => serverIdSet.contains(p.id)).toList();

          // Remove items locally that the server says are no longer there
          final localIds = localItems.map((p) => p.id).toSet();
          final toRemoveLocally = localIds.difference(serverIdSet);
          for (final id in toRemoveLocally) {
            await localDataSource.removeFromWishlist(id);
          }

          return Right(synced);
        } on AuthException {
          // User is not authenticated — always return empty list.
          // Never fall back to local cache, which may contain a previous
          // user's items.
          return Right(<WishlistProduct>[]);
        } catch (_) {
          // Server temporarily unavailable — fall back to local cache.
          return Right(localItems);
        }
      }

      return Right(localItems);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addToWishlist(WishlistProduct product) async {
    try {
      // Save locally first (optimistic update for instant UI)
      await localDataSource.addToWishlist(product);

      if (!EnvConfig.useMock) {
        // Sync to server as best-effort — don't fail the operation if it errors
        try {
          await remoteDataSource.addToWishlist(product.id);
        } catch (_) {
          // Server sync failed — local is already updated, user still sees change
        }
      }

      return Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWishlist(String productId) async {
    try {
      // Remove locally first (optimistic update for instant UI)
      await localDataSource.removeFromWishlist(productId);

      if (!EnvConfig.useMock) {
        // Sync to server as best-effort
        try {
          await remoteDataSource.removeFromWishlist(productId);
        } catch (_) {
          // Server sync failed — local is already updated
        }
      }

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
