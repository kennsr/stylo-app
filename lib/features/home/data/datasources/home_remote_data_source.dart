import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/product_summary_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<BannerModel>> getBanners();
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductSummaryModel>> getFeaturedProducts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<BannerModel>> getBanners() async {
    final response = await apiClient.get('/home/banners');
    final data = response['data'] as List<dynamic>;
    return data
        .map((item) => BannerModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.get(ApiConstants.categories);
    final data = response['data'] as List<dynamic>;
    return data
        .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ProductSummaryModel>> getFeaturedProducts() async {
    final response = await apiClient.get(
      ApiConstants.products,
      queryParams: {'featured': 'true'},
    );
    final data = response['data'] as List<dynamic>;
    return data
        .map((item) =>
            ProductSummaryModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
