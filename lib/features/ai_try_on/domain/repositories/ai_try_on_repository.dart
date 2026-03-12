import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/body_avatar.dart';
import '../entities/fit_profile.dart';
import '../entities/try_on_result.dart';

abstract class AiTryOnRepository {
  Future<Either<Failure, TryOnResult>> generateTryOn({
    required String productId,
    String? userPhotoBase64,
    String? avatarId,
  });

  Future<Either<Failure, List<BodyAvatar>>> getAvatars();

  Future<Either<Failure, List<TryOnResult>>> getTryOnHistory();

  Future<Either<Failure, FitProfile>> getFitProfile();

  Future<Either<Failure, FitProfile>> saveFitProfile(FitProfile profile);
}
