import 'package:equatable/equatable.dart';
import '../../domain/entities/notification_item.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationItem> notifications;

  const NotificationsLoaded({required this.notifications});

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  @override
  List<Object?> get props => [notifications];
}

class NotificationsError extends NotificationsState {
  final String message;

  const NotificationsError({required this.message});

  @override
  List<Object?> get props => [message];
}
