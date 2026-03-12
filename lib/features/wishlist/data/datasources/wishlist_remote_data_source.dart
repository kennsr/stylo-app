import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';

abstract class WishlistRemoteDataSource {
  /// Returns list of product_ids currently in the user's server-side wishlist.
  Future<List<String>> getWishlistedIds();

  /// Adds product to server-side wishlist.
  /// Silently succeeds if the product is already there (409 handled gracefully).
  Future<void> addToWishlist(String productId);

  /// Removes product from server-side wishlist.
  /// Silently succeeds if the product wasn't in the wishlist (404 handled).
  Future<void> removeFromWishlist(String productId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final ApiClient apiClient;

  WishlistRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<String>> getWishlistedIds() async {
    try {
      final response = await apiClient.get(ApiConstants.wishlist);
      final List<dynamic> data = response['data'] as List<dynamic>? ?? [];
      // API response: [{ id, product_id, added_at }, ...]
      return data
          .map((item) => item['product_id'] as String? ?? '')
          .where((id) => id.isNotEmpty)
          .toList();
    } on AuthException {
      // Propagate so the repository can return an empty wishlist for guests
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal mengambil wishlist: $e');
    }
  }

  @override
  Future<void> addToWishlist(String productId) async {
    try {
      await apiClient.post(
        ApiConstants.wishlist,
        body: {'product_id': productId},
      );
    } on AuthException {
      rethrow;
    } on ServerException catch (e) {
      // 409 Conflict = already in wishlist — treat as success
      if (e.statusCode == 409) return;
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal menambah ke wishlist: $e');
    }
  }

  @override
  Future<void> removeFromWishlist(String productId) async {
    try {
      await apiClient.delete('${ApiConstants.wishlist}/$productId');
    } on AuthException {
      rethrow;
    } on ServerException catch (e) {
      // 404 = wasn't in wishlist — treat as success
      if (e.statusCode == 404) return;
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal menghapus dari wishlist: $e');
    }
  }
}
