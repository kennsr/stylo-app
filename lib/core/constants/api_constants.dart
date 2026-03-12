import 'env_config.dart';

class ApiConstants {
  static String get baseUrl {
    switch (EnvConfig.current) {
      case Environment.production:
        return 'https://api.stylo.id/v1';
      case Environment.staging:
        return 'https://staging-api.stylo.id/v1';
      case Environment.dev:
        return 'https://04d3-182-253-251-196.ngrok-free.app/v1';
      case Environment.mock:
        return 'https://04d3-182-253-251-196.ngrok-free.app/v1';
    }
  }

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';

  // Products
  static const String products = '/products';
  static const String categories = '/products/categories';

  // Try-On
  static const String tryOn = '/try-on/generate';
  static const String tryOnAvatars = '/try-on/avatars';
  static const String tryOnResults = '/try-on/results';

  // Cart & Checkout
  static const String cart = '/cart';
  static const String checkoutAddresses = '/checkout/addresses';
  static const String checkoutShipping = '/checkout/shipping-rates';
  static const String checkoutPayments = '/checkout/payment-methods';
  static const String checkoutPlaceOrder = '/checkout/place-order';

  // Orders
  static const String orders = '/orders';

  // Wishlist
  static const String wishlist = '/wishlist';

  // Profile
  static const String profile = '/profile';
}
