import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/payment_method.dart';
import '../models/placed_order_model.dart';
import '../models/shipping_address_model.dart';
import '../models/shipping_option_model.dart';

abstract class CheckoutRemoteDataSource {
  Future<List<ShippingAddressModel>> getAddresses();
  Future<List<ShippingOptionModel>> getShippingOptions({
    required String addressId,
    required double weight,
  });
  Future<List<PaymentMethod>> getPaymentMethods();
  Future<PlacedOrderModel> placeOrder({
    required String addressId,
    required String shippingOptionId,
    required String paymentMethod,
  });
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final ApiClient apiClient;

  CheckoutRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ShippingAddressModel>> getAddresses() async {
    try {
      final response = await apiClient.get(ApiConstants.checkoutAddresses);
      final List<dynamic> data =
          response['data'] as List<dynamic>? ?? (response['addresses'] as List<dynamic>? ?? []);
      return data
          .map((json) => ShippingAddressModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal mengambil daftar alamat: $e');
    }
  }

  @override
  Future<List<ShippingOptionModel>> getShippingOptions({
    required String addressId,
    required double weight,
  }) async {
    try {
      final response = await apiClient.get(
        ApiConstants.checkoutShipping,
        queryParams: {
          'address_id': addressId,
          'weight': weight.toString(),
        },
      );
      final List<dynamic> data =
          response['data'] as List<dynamic>? ?? (response['shipping_options'] as List<dynamic>? ?? []);
      return data
          .map((json) =>
              ShippingOptionModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal mengambil opsi pengiriman: $e');
    }
  }

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async {
    try {
      final response = await apiClient.get(ApiConstants.checkoutPayments);
      final List<dynamic> data =
          response['data'] as List<dynamic>? ?? [];
      return data
          .map((json) => PaymentMethod.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal mengambil metode pembayaran: $e');
    }
  }

  @override
  Future<PlacedOrderModel> placeOrder({
    required String addressId,
    required String shippingOptionId,
    required String paymentMethod,
  }) async {
    try {
      final response = await apiClient.post(
        ApiConstants.checkoutPlaceOrder,
        body: {
          'address_id': addressId,
          'shipping_option_id': shippingOptionId,
          'payment_method': paymentMethod,
        },
      );
      final data = response['data'] as Map<String, dynamic>? ?? response;
      return PlacedOrderModel.fromJson(data);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal membuat pesanan: $e');
    }
  }
}
