import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/notifications_repository.dart';

class MarkAsReadUseCase implements UseCase<void, String> {
  final NotificationsRepository repository;

  MarkAsReadUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return repository.markAsRead(params);
  }
}
