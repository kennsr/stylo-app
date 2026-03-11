import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/either.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    String? category,
    String? search,
    int page = 1,
    int pageSize = 20,
  }) async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return  Left(NetworkFailure());
    }
    try {
      final models = await remoteDataSource.getProducts(
        category: category,
        search: search,
        page: page,
        pageSize: pageSize,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductDetail(String productId) async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return  Left(NetworkFailure());
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
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return  Left(NetworkFailure());
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
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getReviews(String productId) async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return  Left(NetworkFailure());
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
    }
  }
}
