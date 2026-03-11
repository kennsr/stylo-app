import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final ApiClient apiClient;

  NotificationsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await apiClient.get('/notifications');
      final List<dynamic> data =
          response['data'] as List<dynamic>? ?? [];
      return data
          .map((json) =>
              NotificationModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal memuat notifikasi: $e');
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    try {
      await apiClient.patch('/notifications/$id/read');
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal menandai notifikasi: $e');
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      await apiClient.patch('/notifications/read-all');
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal menandai semua notifikasi: $e');
    }
  }
}
