import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/either.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';
import 'package:stylo/features/product/domain/entities/product.dart';
import 'package:stylo/features/product/domain/entities/product_list_result.dart';
import 'package:stylo/features/product/domain/entities/review.dart';
import 'package:stylo/features/product/domain/repositories/product_repository.dart';
import 'package:stylo/features/product/data/datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProductListResult>> getProducts({
    String? category,
    String? search,
    int page = 1,
    int pageSize = 20,
  }) async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return Left(NetworkFailure());
    }
    try {
      final modelsFuture = remoteDataSource.getProducts(
        category: category,
        search: search,
        page: page,
        pageSize: pageSize,
      );

      // Only fetch count on the first page to optimize
      final countFuture = page == 1
          ? remoteDataSource.getProductCount(category: category, search: search)
          : Future.value(-1); // -1 indicates we should use the previous total

      final results = await Future.wait([modelsFuture, countFuture]);
      final models = results[0] as List<ProductModel>;
      final count = results[1] as int;

      return Right(
        ProductListResult(
          products: models.map((m) => m.toEntity()).toList(),
          totalProducts: count,
        ),
      );
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      // Catch TypeError / FormatException from JSON parsing so they don't
      // escape the Either boundary and leave the UI stuck on a skeleton.
      return Left(ServerFailure(message: 'Gagal memproses data produk: $e'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductDetail(String productId) async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return Left(NetworkFailure());
    }
    try {
      final model = await remoteDataSource.getProductDetail(productId);
      return Right(model.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Gagal memproses detail produk: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return Left(NetworkFailure());
    }
    try {
      final models = await remoteDataSource.searchProducts(query);
      return Right(models.map((m) => m.toEntity()).toList());
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Gagal mencari produk: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getReviews(String productId) async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return Left(NetworkFailure());
    }
    try {
      final models = await remoteDataSource.getReviews(productId);
      return Right(models.map((m) => m.toEntity()).toList());
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Gagal memuat ulasan: $e'));
    }
  }
}
