import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<CartModel?> getCart();
  Future<void> saveCart(CartModel cart);
  Future<void> clearCart();
}

const _kCachedCart = 'cached_cart';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences prefs;

  CartLocalDataSourceImpl({required this.prefs});

  @override
  Future<CartModel?> getCart() async {
    try {
      final jsonStr = prefs.getString(_kCachedCart);
      if (jsonStr == null) return null;
      final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;
      return CartModel.fromJson(decoded);
    } catch (e) {
      throw CacheException(message: 'Gagal membaca keranjang dari cache: $e');
    }
  }

  @override
  Future<void> saveCart(CartModel cart) async {
    try {
      final jsonStr = jsonEncode(cart.toJson());
      await prefs.setString(_kCachedCart, jsonStr);
    } catch (e) {
      throw CacheException(message: 'Gagal menyimpan keranjang ke cache: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await prefs.remove(_kCachedCart);
    } catch (e) {
      throw CacheException(message: 'Gagal menghapus keranjang dari cache: $e');
    }
  }
}
