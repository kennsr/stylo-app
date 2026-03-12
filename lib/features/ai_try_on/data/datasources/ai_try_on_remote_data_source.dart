import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/body_avatar.dart';
import '../models/fit_profile_model.dart';
import '../models/try_on_result_model.dart';

abstract class AiTryOnRemoteDataSource {
  Future<TryOnResultModel> generateTryOn({
    required String productId,
    String? userPhotoBase64,
    String? avatarId,
  });

  Future<List<BodyAvatar>> getAvatars();

  Future<List<TryOnResultModel>> getTryOnHistory();

  Future<FitProfileModel> getFitProfile();

  Future<FitProfileModel> saveFitProfile(FitProfileModel profile);
}

class AiTryOnRemoteDataSourceImpl implements AiTryOnRemoteDataSource {
  final ApiClient apiClient;

  AiTryOnRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<TryOnResultModel> generateTryOn({
    required String productId,
    String? userPhotoBase64,
    String? avatarId,
  }) async {
    assert(
      userPhotoBase64 != null || avatarId != null,
      'Either userPhotoBase64 or avatarId must be provided',
    );

    // New API contract uses camelCase 'productId' and 'photo'
    final body = <String, dynamic>{'productId': productId};
    if (userPhotoBase64 != null) body['photo'] = userPhotoBase64;
    if (avatarId != null) body['avatarId'] = avatarId;

    final response = await apiClient.post(
      ApiConstants.tryOn,
      body: body,
    );

    final data = response['data'];
    if (data == null) {
      throw ServerException(message: 'Data tidak ditemukan');
    }

    return TryOnResultModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<List<BodyAvatar>> getAvatars() async {
    try {
      final response = await apiClient.get(ApiConstants.tryOnAvatars);
      final List<dynamic> data =
          response['data'] as List<dynamic>? ?? [];
      return data
          .map((json) => BodyAvatar.fromJson(json as Map<String, dynamic>))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Gagal mengambil daftar avatar: $e');
    }
  }

  @override
  Future<List<TryOnResultModel>> getTryOnHistory() async {
    final response = await apiClient.get('/try-on/results');

    final data = response['data'];
    if (data == null) {
      throw ServerException(message: 'Data tidak ditemukan');
    }

    final list = data as List<dynamic>;
    return list
        .map(
          (item) => TryOnResultModel.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<FitProfileModel> getFitProfile() async {
    final response = await apiClient.get('/profile/fit-profile');

    final data = response['data'];
    if (data == null) {
      throw ServerException(message: 'Data tidak ditemukan');
    }

    return FitProfileModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<FitProfileModel> saveFitProfile(FitProfileModel profile) async {
    final response = await apiClient.put(
      '/profile/fit-profile',
      body: profile.toJson(),
    );

    final data = response['data'];
    if (data == null) {
      throw ServerException(message: 'Data tidak ditemukan');
    }

    return FitProfileModel.fromJson(data as Map<String, dynamic>);
  }
}
