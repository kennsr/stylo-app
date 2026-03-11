import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase extends UseCase<User, NoParams> {
  final AuthRepository repository;
  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) =>
      repository.getCurrentUser();
}
