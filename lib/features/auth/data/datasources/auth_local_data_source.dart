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
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;
  AuthLocalDataSourceImpl(this.prefs);

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
}
