import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/banner.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product_summary.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Banner>>> getBanners() async {
    if (!await networkInfo.isConnected) {
      return  Left(NetworkFailure());
    }
    try {
      final models = await remoteDataSource.getBanners();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    if (!await networkInfo.isConnected) {
      return  Left(NetworkFailure());
    }
    try {
      final models = await remoteDataSource.getCategories();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductSummary>>> getFeaturedProducts() async {
    if (!await networkInfo.isConnected) {
      return  Left(NetworkFailure());
    }
    try {
      final models = await remoteDataSource.getFeaturedProducts();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    }
  }
}
