import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/notification_item.dart';
import '../repositories/notifications_repository.dart';

class GetNotificationsUseCase
    implements UseCase<List<NotificationItem>, NoParams> {
  final NotificationsRepository repository;

  GetNotificationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<NotificationItem>>> call(NoParams params) {
    return repository.getNotifications();
  }
}
