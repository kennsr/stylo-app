import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/profile_repository.dart';

class UpdateStylePreferencesUseCase
    implements UseCase<void, List<String>> {
  final ProfileRepository repository;

  UpdateStylePreferencesUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(List<String> params) {
    return repository.updateStylePreferences(params);
  }
}
