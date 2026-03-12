import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/body_avatar.dart';
import '../repositories/ai_try_on_repository.dart';

class GetAvatarsUseCase extends UseCase<List<BodyAvatar>, NoParams> {
  final AiTryOnRepository repository;

  GetAvatarsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<BodyAvatar>>> call(NoParams params) {
    return repository.getAvatars();
  }
}
