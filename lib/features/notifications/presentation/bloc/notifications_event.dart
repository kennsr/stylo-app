import 'package:equatable/equatable.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object?> get props => [];
}

class NotificationsFetch extends NotificationsEvent {
  const NotificationsFetch();
}

class NotificationsMarkRead extends NotificationsEvent {
  final String id;

  const NotificationsMarkRead({required this.id});

  @override
  List<Object?> get props => [id];
}

class NotificationsMarkAllRead extends NotificationsEvent {
  const NotificationsMarkAllRead();
}
