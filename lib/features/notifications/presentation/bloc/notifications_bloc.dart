import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/entities/notification_item.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import '../../domain/usecases/mark_as_read_usecase.dart';
import '../../domain/usecases/mark_all_as_read_usecase.dart';
import '../../data/models/notification_model.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc
    extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkAsReadUseCase markAsReadUseCase;
  final MarkAllAsReadUseCase markAllAsReadUseCase;

  NotificationsBloc({
    required this.getNotificationsUseCase,
    required this.markAsReadUseCase,
    required this.markAllAsReadUseCase,
  }) : super(const NotificationsInitial()) {
    on<NotificationsFetch>(_onFetch);
    on<NotificationsMarkRead>(_onMarkRead);
    on<NotificationsMarkAllRead>(_onMarkAllRead);
  }

  Future<void> _onFetch(
    NotificationsFetch event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(const NotificationsLoading());
    final result = await getNotificationsUseCase(const NoParams());
    result.fold(
      (failure) => emit(NotificationsError(message: failure.message)),
      (notifications) => emit(NotificationsLoaded(notifications: notifications)),
    );
  }

  Future<void> _onMarkRead(
    NotificationsMarkRead event,
    Emitter<NotificationsState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationsLoaded) {
      // Optimistic update: mark locally without refetching
      final updatedNotifications = currentState.notifications.map((n) {
        if (n.id == event.id) {
          return NotificationModel(
            id: n.id,
            title: n.title,
            body: n.body,
            type: n.type,
            isRead: true,
            createdAt: n.createdAt,
            imageUrl: n.imageUrl,
            actionRoute: n.actionRoute,
          ) as NotificationItem;
        }
        return n;
      }).toList();
      emit(NotificationsLoaded(notifications: updatedNotifications));

      // Fire-and-forget the API call
      await markAsReadUseCase(event.id);
    }
  }

  Future<void> _onMarkAllRead(
    NotificationsMarkAllRead event,
    Emitter<NotificationsState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationsLoaded) {
      // Optimistic update: mark all as read locally
      final updatedNotifications = currentState.notifications.map((n) {
        return NotificationModel(
          id: n.id,
          title: n.title,
          body: n.body,
          type: n.type,
          isRead: true,
          createdAt: n.createdAt,
          imageUrl: n.imageUrl,
          actionRoute: n.actionRoute,
        ) as NotificationItem;
      }).toList();
      emit(NotificationsLoaded(notifications: updatedNotifications));

      // Fire-and-forget the API call
      await markAllAsReadUseCase(const NoParams());
    }
  }
}
