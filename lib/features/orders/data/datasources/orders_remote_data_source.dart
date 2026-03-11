import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/order_detail_model.dart';
import '../models/order_summary_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderSummaryModel>> getOrders();
  Future<OrderDetailModel> getOrderDetail(String orderId);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiClient apiClient;

  OrdersRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<OrderSummaryModel>> getOrders() async {
    try {
      final response = await apiClient.get(ApiConstants.orders);
      final List<dynamic> data =
          response['data'] as List<dynamic>? ?? (response['orders'] as List<dynamic>? ?? []);
      return data
          .map((json) =>
              OrderSummaryModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal mengambil riwayat pesanan: $e');
    }
  }

  @override
  Future<OrderDetailModel> getOrderDetail(String orderId) async {
    try {
      final response = await apiClient.get('${ApiConstants.orders}/$orderId');
      final data = response['data'] as Map<String, dynamic>? ?? response;
      return OrderDetailModel.fromJson(data);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal mengambil detail pesanan: $e');
    }
  }
}
