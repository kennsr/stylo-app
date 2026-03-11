import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/style_preference.dart';
import '../repositories/profile_repository.dart';

class GetStylePreferencesUseCase
    implements UseCase<List<StylePreference>, NoParams> {
  final ProfileRepository repository;

  GetStylePreferencesUseCase(this.repository);

  @override
  Future<Either<Failure, List<StylePreference>>> call(NoParams params) {
    return repository.getStylePreferences();
  }
}
