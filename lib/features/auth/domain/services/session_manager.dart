import '../../../../core/network/network_info.dart';
import '../../data/datasources/auth_local_data_source.dart';

/// Enterprise-level session manager that handles:
/// - Session persistence across app restarts
/// - Token expiry validation
/// - Automatic token refresh (when supported by backend)
/// - Session age limits (max 30 days)
/// - Network-aware session validation
class SessionManager {
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SessionManager({
    required this.localDataSource,
    required this.networkInfo,
  });

  /// Check if user has a valid session that persists across app restarts
  Future<bool> hasValidSession() async {
    return await localDataSource.isSessionValid();
  }

  /// Get the current session token if valid
  Future<String?> getSessionToken() async {
    final isValid = await hasValidSession();
    if (!isValid) return null;
    return await localDataSource.getSessionToken();
  }

  /// Get time remaining until session expires
  Future<Duration?> getSessionTimeRemaining() async {
    final expiry = await localDataSource.getTokenExpiry();
    if (expiry == null) return null;
    
    final now = DateTime.now();
    if (now.isAfter(expiry)) return Duration.zero;
    
    return expiry.difference(now);
  }

  /// Get session age (time since last login)
  Future<Duration?> getSessionAge() async {
    final lastLogin = await localDataSource.getLastLoginTime();
    if (lastLogin == null) return null;
    return DateTime.now().difference(lastLogin);
  }

  /// Check if session should be refreshed
  Future<bool> needsRefresh() async {
    return await localDataSource.shouldRefreshToken();
  }

  /// Check if we can attempt a token refresh (rate limited)
  Future<bool> canRefresh() async {
    return await localDataSource.canRefreshToken();
  }

  /// Record that a token refresh was attempted
  Future<void> markRefreshed() async {
    await localDataSource.cacheLastRefreshTime(DateTime.now());
  }

  /// Clear session data (used on logout)
  Future<void> clearSession() async {
    await localDataSource.clearSession();
  }

  /// Get session info for debugging
  Future<Map<String, dynamic>> getSessionInfo() async {
    final token = await localDataSource.getSessionToken();
    final expiry = await localDataSource.getTokenExpiry();
    final lastLogin = await localDataSource.getLastLoginTime();
    final lastRefresh = await localDataSource.getLastRefreshTime();
    final hasNetwork = await networkInfo.isConnected;

    return {
      'has_token': token != null && token.isNotEmpty,
      'expiry': expiry?.toIso8601String(),
      'last_login': lastLogin?.toIso8601String(),
      'last_refresh': lastRefresh?.toIso8601String(),
      'has_network': hasNetwork,
      'is_valid': await hasValidSession(),
      'needs_refresh': await needsRefresh(),
      'can_refresh': await canRefresh(),
      'time_remaining': await getSessionTimeRemaining(),
      'session_age': await getSessionAge(),
    };
  }
}
