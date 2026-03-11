import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/cart_item_model.dart';
import '../models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart();
  Future<CartModel> addItem(CartItemModel item);
  Future<CartModel> removeItem(String itemId);
  Future<CartModel> updateItem(String itemId, int quantity);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiClient apiClient;

  CartRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<CartModel> getCart() async {
    try {
      final response = await apiClient.get(ApiConstants.cart);
      final data = response['data'] as Map<String, dynamic>? ?? response;
      return CartModel.fromJson(data);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal mengambil keranjang: $e');
    }
  }

  @override
  Future<CartModel> addItem(CartItemModel item) async {
    try {
      final response = await apiClient.post(
        '${ApiConstants.cart}/items',
        body: item.toJson(),
      );
      final data = response['data'] as Map<String, dynamic>? ?? response;
      return CartModel.fromJson(data);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal menambahkan item ke keranjang: $e');
    }
  }

  @override
  Future<CartModel> removeItem(String itemId) async {
    try {
      final response = await apiClient.delete('${ApiConstants.cart}/items/$itemId');
      final data = response['data'] as Map<String, dynamic>? ?? response;
      return CartModel.fromJson(data);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal menghapus item dari keranjang: $e');
    }
  }

  @override
  Future<CartModel> updateItem(String itemId, int quantity) async {
    try {
      final response = await apiClient.put(
        '${ApiConstants.cart}/items/$itemId',
        body: {'quantity': quantity},
      );
      final data = response['data'] as Map<String, dynamic>? ?? response;
      return CartModel.fromJson(data);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal mengubah jumlah item: $e');
    }
  }
}
