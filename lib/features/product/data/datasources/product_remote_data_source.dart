import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    String? category,
    String? search,
    int page = 1,
    int pageSize = 20,
  });

  Future<ProductModel> getProductDetail(String productId);

  Future<List<ProductModel>> searchProducts(String query);

  Future<List<ReviewModel>> getReviews(String productId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getProducts({
    String? category,
    String? search,
    int page = 1,
    int pageSize = 20,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };
    if (category != null && category != 'Semua') {
      queryParams['category'] = category;
    }
    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    final response = await apiClient.get(
      '/products',
      queryParams: queryParams,
    );

    final data = response['data'];
    if (data == null) {
      throw  ServerException(message: 'Data tidak ditemukan');
    }

    final list = data as List<dynamic>;
    return list
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ProductModel> getProductDetail(String productId) async {
    final response = await apiClient.get('/products/$productId');

    final data = response['data'];
    if (data == null) {
      throw  ServerException(message: 'Produk tidak ditemukan');
    }

    return ProductModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    final response = await apiClient.get(
      '/products/search',
      queryParams: {'q': query},
    );

    final data = response['data'];
    if (data == null) {
      throw  ServerException(message: 'Data tidak ditemukan');
    }

    final list = data as List<dynamic>;
    return list
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ReviewModel>> getReviews(String productId) async {
    final response = await apiClient.get('/products/$productId/reviews');

    final data = response['data'];
    if (data == null) {
      throw  ServerException(message: 'Data tidak ditemukan');
    }

    final list = data as List<dynamic>;
    return list
        .map((item) => ReviewModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
