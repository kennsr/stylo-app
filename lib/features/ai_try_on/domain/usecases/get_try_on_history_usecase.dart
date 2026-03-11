import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/try_on_result.dart';
import '../repositories/ai_try_on_repository.dart';

class GetTryOnHistoryUseCase
    extends UseCase<List<TryOnResult>, NoParams> {
  final AiTryOnRepository repository;

  GetTryOnHistoryUseCase({required this.repository});

  @override
  Future<Either<Failure, List<TryOnResult>>> call(NoParams params) {
    return repository.getTryOnHistory();
  }
}
