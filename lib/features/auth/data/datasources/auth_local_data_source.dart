import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getToken();
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCache();
  Future<bool> isLoggedIn();
  
  /// Session persistence methods
  Future<void> cacheSessionToken(String token, {DateTime? expiresAt});
  Future<String?> getSessionToken();
  Future<DateTime?> getTokenExpiry();
  Future<void> cacheLastLoginTime(DateTime time);
  Future<DateTime?> getLastLoginTime();
  Future<bool> isSessionValid({Duration? maxAge});
  Future<void> clearSession();
  
  /// Token refresh methods
  Future<void> cacheLastRefreshTime(DateTime time);
  Future<DateTime?> getLastRefreshTime();
  Future<bool> canRefreshToken();
  Future<bool> shouldRefreshToken();
}

/// Enterprise session configuration
class SessionConfig {
  /// Maximum session age before requiring re-authentication (30 days)
  /// This is the industry standard for consumer apps (Instagram, Facebook, etc.)
  static const maxSessionAge = Duration(days: 30);
  
  /// Token refresh threshold - refresh when less than this time remaining (5 minutes)
  static const refreshThreshold = Duration(minutes: 5);
  
  /// Minimum time between token refresh attempts (1 minute)
  static const minRefreshInterval = Duration(minutes: 1);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;
  AuthLocalDataSourceImpl(this.prefs);

  // Legacy token methods (kept for backward compatibility)
  @override
  Future<void> cacheToken(String token) async {
    await prefs.setString(AppConstants.tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString(AppConstants.tokenKey);
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    await prefs.setString(AppConstants.userKey, jsonEncode(user.toJson()));
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final json = prefs.getString(AppConstants.userKey);
    if (json == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      throw  CacheException(message: 'Failed to parse cached user');
    }
  }

  @override
  Future<void> clearCache() async {
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove(AppConstants.userKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    return prefs.getString(AppConstants.tokenKey) != null;
  }

  // ─── Enterprise Session Management ──────────────────────────────────────

  static const _sessionTokenKey = 'stylo_session_token';
  static const _tokenExpiryKey = 'stylo_token_expiry';
  static const _lastLoginKey = 'stylo_last_login';
  static const _lastRefreshKey = 'stylo_last_refresh';

  @override
  Future<void> cacheSessionToken(String token, {DateTime? expiresAt}) async {
    await prefs.setString(_sessionTokenKey, token);
    if (expiresAt != null) {
      await prefs.setString(_tokenExpiryKey, expiresAt.toIso8601String());
    }
    await cacheLastLoginTime(DateTime.now());
  }

  @override
  Future<String?> getSessionToken() async {
    return prefs.getString(_sessionTokenKey);
  }

  @override
  Future<DateTime?> getTokenExpiry() async {
    final expiryStr = prefs.getString(_tokenExpiryKey);
    if (expiryStr == null) return null;
    try {
      return DateTime.parse(expiryStr);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cacheLastLoginTime(DateTime time) async {
    await prefs.setString(_lastLoginKey, time.toIso8601String());
  }

  @override
  Future<DateTime?> getLastLoginTime() async {
    final timeStr = prefs.getString(_lastLoginKey);
    if (timeStr == null) return null;
    try {
      return DateTime.parse(timeStr);
    } catch (_) {
      return null;
    }
  }

  /// Validates if the current session is still valid based on:
  /// 1. Token exists
  /// 2. Token hasn't expired
  /// 3. Last login is within [maxAge] (defaults to [SessionConfig.maxSessionAge])
  @override
  Future<bool> isSessionValid({Duration? maxAge}) async {
    final token = await getSessionToken();
    if (token == null || token.isEmpty) return false;

    // Check token expiry if available
    final expiry = await getTokenExpiry();
    if (expiry != null && DateTime.now().isAfter(expiry)) {
      return false;
    }

    // Check last login age
    final lastLogin = await getLastLoginTime();
    if (lastLogin != null) {
      final age = DateTime.now().difference(lastLogin);
      final allowedAge = maxAge ?? SessionConfig.maxSessionAge;
      if (age > allowedAge) {
        return false;
      }
    }

    return true;
  }

  @override
  Future<void> clearSession() async {
    await prefs.remove(_sessionTokenKey);
    await prefs.remove(_tokenExpiryKey);
    await prefs.remove(_lastLoginKey);
    await prefs.remove(_lastRefreshKey);
    // Also clear legacy keys
    await prefs.remove(AppConstants.tokenKey);
  }

  /// Cache the last token refresh time (for rate limiting refresh attempts)
  @override
  Future<void> cacheLastRefreshTime(DateTime time) async {
    await prefs.setString(_lastRefreshKey, time.toIso8601String());
  }

  /// Get the last token refresh time
  @override
  Future<DateTime?> getLastRefreshTime() async {
    final timeStr = prefs.getString(_lastRefreshKey);
    if (timeStr == null) return null;
    try {
      return DateTime.parse(timeStr);
    } catch (_) {
      return null;
    }
  }

  /// Check if enough time has passed since last refresh attempt
  @override
  Future<bool> canRefreshToken() async {
    final lastRefresh = await getLastRefreshTime();
    if (lastRefresh == null) return true;
    final elapsed = DateTime.now().difference(lastRefresh);
    return elapsed > SessionConfig.minRefreshInterval;
  }

  /// Check if token should be refreshed (approaching expiry)
  @override
  Future<bool> shouldRefreshToken() async {
    final expiry = await getTokenExpiry();
    if (expiry == null) return false;
    
    final now = DateTime.now();
    if (now.isAfter(expiry)) return false; // Already expired, need re-login
    
    final timeUntilExpiry = expiry.difference(now);
    return timeUntilExpiry < SessionConfig.refreshThreshold;
  }
}
