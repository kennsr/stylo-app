import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/notification_item.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<NotificationItem>>> getNotifications();
  Future<Either<Failure, void>> markAsRead(String id);
  Future<Either<Failure, void>> markAllAsRead();
}
