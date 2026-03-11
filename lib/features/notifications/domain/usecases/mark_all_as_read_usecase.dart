import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/notifications_repository.dart';

class MarkAllAsReadUseCase implements UseCase<void, NoParams> {
  final NotificationsRepository repository;

  MarkAllAsReadUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.markAllAsRead();
  }
}
