import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/fit_profile.dart';
import '../repositories/ai_try_on_repository.dart';

class SaveFitProfileParams extends Equatable {
  final FitProfile profile;

   const SaveFitProfileParams({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class SaveFitProfileUseCase extends UseCase<FitProfile, SaveFitProfileParams> {
  final AiTryOnRepository repository;

  SaveFitProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, FitProfile>> call(SaveFitProfileParams params) {
    return repository.saveFitProfile(params.profile);
  }
}
