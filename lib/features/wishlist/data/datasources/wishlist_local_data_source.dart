import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../wishlist/domain/entities/wishlist_product.dart';

abstract class WishlistLocalDataSource {
  Future<List<WishlistProduct>> getWishlist();
  Future<void> addToWishlist(WishlistProduct product);
  Future<void> removeFromWishlist(String productId);
  Future<bool> isWishlisted(String productId);
}

const _kWishlistKey = 'stylo_wishlist';

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  final SharedPreferences prefs;

  WishlistLocalDataSourceImpl({required this.prefs});

  @override
  Future<List<WishlistProduct>> getWishlist() async {
    try {
      final jsonStr = prefs.getString(_kWishlistKey);
      if (jsonStr == null) return [];
      final List<dynamic> decoded = jsonDecode(jsonStr) as List<dynamic>;
      return decoded
          .map((e) => WishlistProduct.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheException(message: 'Gagal membaca wishlist: $e');
    }
  }

  @override
  Future<void> addToWishlist(WishlistProduct product) async {
    try {
      final current = await getWishlist();
      if (current.any((p) => p.id == product.id)) return; // already exists
      final updated = [...current, product];
      await prefs.setString(
        _kWishlistKey,
        jsonEncode(updated.map((p) => p.toJson()).toList()),
      );
    } catch (e) {
      throw CacheException(message: 'Gagal menyimpan ke wishlist: $e');
    }
  }

  @override
  Future<void> removeFromWishlist(String productId) async {
    try {
      final current = await getWishlist();
      final updated = current.where((p) => p.id != productId).toList();
      await prefs.setString(
        _kWishlistKey,
        jsonEncode(updated.map((p) => p.toJson()).toList()),
      );
    } catch (e) {
      throw CacheException(message: 'Gagal menghapus dari wishlist: $e');
    }
  }

  @override
  Future<bool> isWishlisted(String productId) async {
    try {
      final current = await getWishlist();
      return current.any((p) => p.id == productId);
    } catch (e) {
      return false;
    }
  }
}
