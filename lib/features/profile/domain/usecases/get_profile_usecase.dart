import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../features/auth/domain/entities/user.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase implements UseCase<User, NoParams> {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return repository.getProfile();
  }
}
