import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/fit_profile_model.dart';
import '../models/try_on_result_model.dart';

abstract class AiTryOnRemoteDataSource {
  Future<TryOnResultModel> generateTryOn({
    required String productId,
    required String userPhotoBase64,
  });

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
    required String userPhotoBase64,
  }) async {
    final response = await apiClient.post(
      '/try-on/generate',
      body: {
        'productId': productId,
        'photo': userPhotoBase64,
      },
    );

    final data = response['data'];
    if (data == null) {
      throw  ServerException(message: 'Data tidak ditemukan');
    }

    return TryOnResultModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<List<TryOnResultModel>> getTryOnHistory() async {
    final response = await apiClient.get('/try-on/results');

    final data = response['data'];
    if (data == null) {
      throw  ServerException(message: 'Data tidak ditemukan');
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
      throw  ServerException(message: 'Data tidak ditemukan');
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
      throw  ServerException(message: 'Data tidak ditemukan');
    }

    return FitProfileModel.fromJson(data as Map<String, dynamic>);
  }
}
