import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Returns the UserModel + token extracted from the login response.
  Future<({UserModel user, String token})> login({
    required String email,
    required String password,
  });

  /// Returns the UserModel + token extracted from the register response.
  Future<({UserModel user, String token})> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<UserModel> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;
  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<({UserModel user, String token})> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiClient.post(
        ApiConstants.login,
        body: {'email': email, 'password': password},
      );
      final data = response['data'] as Map<String, dynamic>;
      return _parseAuthResponse(data);
    } on AuthException {
      // 401 on the login endpoint means wrong credentials, not an expired
      // session — rethrow as ServerException so the repository surfaces a
      // user-friendly message instead of the generic "Sesi habis..." text.
      throw ServerException(
        message: 'Email atau kata sandi salah. Belum punya akun? Silakan daftar.',
      );
    }
  }

  @override
  Future<({UserModel user, String token})> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiClient.post(
        ApiConstants.register,
        body: {'name': name, 'email': email, 'password': password},
      );
      final data = response['data'] as Map<String, dynamic>;
      return _parseAuthResponse(data);
    } on AuthException {
      // 401 on register = conflict / policy rejection — surface clearly.
      throw ServerException(
        message: 'Pendaftaran ditolak. Email mungkin sudah terdaftar.',
      );
    }
  }

  @override
  Future<void> logout() async {
    await apiClient.post(ApiConstants.logout);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await apiClient.get(ApiConstants.me);
    final data = response['data'] as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }

  /// Handles two common backend shapes:
  ///   A) { user: {...}, token: "..." }   ← nested
  ///   B) { id: "...", name: "...", token: "..." }  ← flat (current mock)
  ({UserModel user, String token}) _parseAuthResponse(
    Map<String, dynamic> data,
  ) {
    final String token =
        data['token'] as String? ??
        data['access_token'] as String? ??
        '';

    // Shape A: user is nested under 'user' key
    final userJson = data['user'] as Map<String, dynamic>? ?? data;
    final user = UserModel.fromJson(userJson);

    return (user: user, token: token);
  }
}
