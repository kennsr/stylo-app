enum Environment { mock, dev, staging, production }

class EnvConfig {
  // MUST be `const` — String.fromEnvironment only reads --dart-define values
  // in a compile-time constant context. `static final` causes it to always
  // return the defaultValue at runtime regardless of --dart-define=ENV=xxx.
  static const String _envString = String.fromEnvironment(
    'ENV',
    defaultValue: 'mock',
  );

  static Environment get current {
    switch (_envString.toLowerCase()) {
      case 'production':
        return Environment.production;
      case 'staging':
        return Environment.staging;
      case 'dev':
        return Environment.dev;
      case 'mock':
      default:
        return Environment.mock;
    }
  }

  static bool get useMock => current == Environment.mock;
  static bool get isProduction => current == Environment.production;
  static bool get isDev => current == Environment.dev;
  static bool get isStaging => current == Environment.staging;
}
