import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../auth/data/models/user_model.dart';
import '../models/style_preference_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getProfile();
  Future<UserModel> updateProfile({required String name, String? phone});
  Future<UserModel> uploadAvatar(File avatarFile);
  Future<List<StylePreferenceModel>> getStylePreferences();
  Future<void> updateStylePreferences(List<String> preferenceIds);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await apiClient.get(ApiConstants.profile);
      final data = response['data'] as Map<String, dynamic>? ?? response;
      return UserModel.fromJson(data);
    } on AuthException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal mengambil profil: $e');
    }
  }

  @override
  Future<UserModel> updateProfile({
    required String name,
    String? phone,
  }) async {
    try {
      final body = <String, dynamic>{'name': name};
      if (phone != null) body['phone'] = phone;
      final response = await apiClient.put(ApiConstants.profile, body: body);
      final data = response['data'] as Map<String, dynamic>? ?? response;
      return UserModel.fromJson(data);
    } on AuthException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal memperbarui profil: $e');
    }
  }

  @override
  Future<List<StylePreferenceModel>> getStylePreferences() async {
    try {
      final response =
          await apiClient.get('${ApiConstants.profile}/style-preferences');
      final List<dynamic> data =
          response['data'] as List<dynamic>? ?? (response['preferences'] as List<dynamic>? ?? []);
      return data
          .map((json) =>
              StylePreferenceModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on AuthException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal mengambil preferensi gaya: $e');
    }
  }

  @override
  Future<void> updateStylePreferences(List<String> preferenceIds) async {
    try {
      await apiClient.put(
        '${ApiConstants.profile}/style-preferences',
        body: {'preference_ids': preferenceIds},
      );
    } on AuthException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal memperbarui preferensi gaya: $e');
    }
  }

  @override
  Future<UserModel> uploadAvatar(File avatarFile) async {
    try {
      final imageBytes = await avatarFile.readAsBytes();
      final fileName = avatarFile.path.split('/').last;
      
      // Use ApiClient's multipart upload (handles mock vs real)
      final response = await apiClient.uploadMultipart(
        '${ApiConstants.profile}/avatar',
        files: [
          http.MultipartFile.fromBytes(
            'avatar',
            imageBytes,
            filename: fileName,
          ),
        ],
      );
      
      final data = response['data'] as Map<String, dynamic>? ?? response;
      return UserModel.fromJson(data);
    } on AuthException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal mengunggah avatar: $e');
    }
  }
}
