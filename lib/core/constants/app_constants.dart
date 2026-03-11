class AppConstants {
  static  String appName = 'Stylo';
  static  String currencyCode = 'IDR';
  static  String locale = 'id_ID';
  static const int defaultPageSize = 20;
  static  String onboardingKey = 'has_seen_onboarding';
  static  String themeKey = 'theme_mode';
  static  String tokenKey = 'auth_token';
  static  String userKey = 'cached_user';

  static  List<String> productCategories = [
    'Semua',
    'Batik',
    'Streetwear',
    'Modest',
    'Kasual',
    'Formal',
    'Activewear',
  ];

  static  List<String> paymentMethods = [
    'QRIS',
    'GoPay',
    'OVO',
    'ShopeePay',
    'Virtual Account BCA',
    'Virtual Account BNI',
    'Virtual Account Mandiri',
  ];

  static  List<String> shippingProviders = [
    'JNE',
    'J&T Express',
    'SiCepat',
    'Paxel',
  ];

  static  List<String> stylePreferences = [
    'Batik',
    'Streetwear',
    'Modest',
    'Kasual',
    'Formal',
    'Minimalis',
    'Bohemian',
    'Vintage',
  ];
}
