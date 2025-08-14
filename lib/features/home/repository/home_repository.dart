import '../../brands/data/model/product_model.dart';
import '../data/model/banner_model.dart';
import '../data/model/brand_model.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/services/api/api_service.dart';

abstract class HomeRepository {
  Future<List<BannerModel>> getBanners();
  Future<List<ProductModel>> getFeaturedProducts();
  Future<List<ProductModel>> getNewArrivals();
  Future<List<ProductModel>> getBestSellers();
  Future<List<ProductModel>> getDiscountedProducts();
  Future<List<ProductModel>> searchProducts(String query);
  Future<List<String>> getCategories();
  Future<List<HomeBrandModel>> getBrands({int page = 1, int limit = 10});
}

class HomeRepositoryImpl implements HomeRepository {
  // TODO: Inject API service
  // final ApiService _apiService;
  // HomeRepositoryImpl(this._apiService);

  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/banners');
      // return (response.data['data'] as List)
      //     .map((json) => BannerModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get banners: $e');
    }
  }

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/products/featured');
      // return (response.data['data'] as List)
      //     .map((json) => ProductModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get featured products: $e');
    }
  }

  @override
  Future<List<ProductModel>> getNewArrivals() async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/products/new-arrivals');
      // return (response.data['data'] as List)
      //     .map((json) => ProductModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get new arrivals: $e');
    }
  }

  @override
  Future<List<ProductModel>> getBestSellers() async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/products/best-sellers');
      // return (response.data['data'] as List)
      //     .map((json) => ProductModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get best sellers: $e');
    }
  }

  @override
  Future<List<ProductModel>> getDiscountedProducts() async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/products/discounted');
      // return (response.data['data'] as List)
      //     .map((json) => ProductModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get discounted products: $e');
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/products/search', queryParameters: {'q': query});
      // return (response.data['data'] as List)
      //     .map((json) => ProductModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/categories');
      // return (response.data['data'] as List)
      //     .map((json) => json['name'].toString())
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  @override
  Future<List<HomeBrandModel>> getBrands({int page = 1, int limit = 10}) async {
    try {
      final response = await ApiService.get(
        "${ApiEndPoint.brands}?page=$page&limit=$limit",
      );

      if (response.isSuccess) {
        final parsed = HomeBrandsResponse.fromJson(
          Map<String, dynamic>.from(response.data),
        );
        return parsed.data.data;
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get brands: $e');
    }
  }
}
