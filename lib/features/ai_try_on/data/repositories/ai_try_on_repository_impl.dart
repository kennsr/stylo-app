import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/body_avatar.dart';
import '../../domain/entities/fit_profile.dart';
import '../../domain/entities/try_on_result.dart';
import '../../domain/repositories/ai_try_on_repository.dart';
import '../datasources/ai_try_on_remote_data_source.dart';
import '../models/fit_profile_model.dart';
import '../models/try_on_result_model.dart';

class AiTryOnRepositoryImpl implements AiTryOnRepository {
  final AiTryOnRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AiTryOnRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TryOnResult>> generateTryOn({
    required String productId,
    String? userPhotoBase64,
    String? avatarId,
  }) async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return Left(NetworkFailure());
    }
    try {
      final model = await remoteDataSource.generateTryOn(
        productId: productId,
        userPhotoBase64: userPhotoBase64,
        avatarId: avatarId,
      );
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
  Future<Either<Failure, List<BodyAvatar>>> getAvatars() async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return Left(NetworkFailure());
    }
    try {
      final avatars = await remoteDataSource.getAvatars();
      return Right(avatars);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<TryOnResult>>> getTryOnHistory() async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return Left(NetworkFailure());
    }
    try {
      final models = await remoteDataSource.getTryOnHistory();
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
  Future<Either<Failure, FitProfile>> getFitProfile() async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return Left(NetworkFailure());
    }
    try {
      final model = await remoteDataSource.getFitProfile();
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
  Future<Either<Failure, FitProfile>> saveFitProfile(
    FitProfile profile,
  ) async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      return Left(NetworkFailure());
    }
    try {
      final model = await remoteDataSource.saveFitProfile(
        profile.toModel(),
      );
      return Right(model.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
