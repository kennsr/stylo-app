class ServerException implements Exception {
  final String message;
  final int? statusCode;
   ServerException({this.message = 'Server error', this.statusCode});
  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

class CacheException implements Exception {
  final String message;
   CacheException({this.message = 'Cache error'});
  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;
   NetworkException({this.message = 'Network error'});
  @override
  String toString() => 'NetworkException: $message';
}

class AuthException implements Exception {
  final String message;
   AuthException({this.message = 'Authentication error'});
  @override
  String toString() => 'AuthException: $message';
}
