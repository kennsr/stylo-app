import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/fit_profile.dart';
import '../repositories/ai_try_on_repository.dart';

class GetFitProfileUseCase extends UseCase<FitProfile, NoParams> {
  final AiTryOnRepository repository;

  GetFitProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, FitProfile>> call(NoParams params) {
    return repository.getFitProfile();
  }
}
