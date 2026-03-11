enum Environment { mock, staging, production }

class EnvConfig {
  static  final String _envString = String.fromEnvironment(
    'ENV',
    defaultValue: 'mock',
  );

  static Environment get current {
    switch (_envString.toLowerCase()) {
      case 'production':
        return Environment.production;
      case 'staging':
        return Environment.staging;
      case 'mock':
      default:
        return Environment.mock;
    }
  }

  static bool get useMock => current == Environment.mock;
  static bool get isProduction => current == Environment.production;
}
