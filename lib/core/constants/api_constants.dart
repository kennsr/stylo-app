import 'env_config.dart';

class ApiConstants {
  static String get baseUrl {
    switch (EnvConfig.current) {
      case Environment.production:
        return 'https://api.stylo.id/v1';
      case Environment.staging:
        return 'https://staging-api.stylo.id/v1';
      case Environment.mock:
        return 'https://mock-api.stylo.id/v1';
    }
  }

  static  Duration connectTimeout = Duration(seconds: 30);
  static  Duration receiveTimeout = Duration(seconds: 30);

  // Auth
  static  String login = '/auth/login';
  static  String register = '/auth/register';
  static  String logout = '/auth/logout';
  static  String me = '/auth/me';

  // Products
  static  String products = '/products';
  static  String categories = '/products/categories';

  // Try-On
  static  String tryOn = '/try-on/generate';
  static  String tryOnAvatars = '/try-on/avatars';
  static  String tryOnResults = '/try-on/results';

  // Cart & Checkout
  static  String cart = '/cart';
  static  String checkoutAddresses = '/checkout/addresses';
  static  String checkoutShipping = '/checkout/shipping-rates';
  static  String checkoutPayments = '/checkout/payment-methods';
  static  String checkoutPlaceOrder = '/checkout/place-order';

  // Orders
  static  String orders = '/orders';

  // Profile
  static  String profile = '/profile';
}
