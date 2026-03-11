import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
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
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post(
      ApiConstants.login,
      body: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post(
      ApiConstants.register,
      body: {'name': name, 'email': email, 'password': password},
    );
    return UserModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    await apiClient.post(ApiConstants.logout);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await apiClient.get(ApiConstants.me);
    return UserModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
