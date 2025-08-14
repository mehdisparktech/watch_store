import '../data/model/brand_model.dart';
import '../data/model/product_model.dart';

abstract class BrandsRepository {
  Future<List<BrandModel>> getAllBrands();
  Future<BrandModel?> getBrandById(String brandId);
  Future<List<ProductModel>> getBrandProducts(String brandId);
}

class BrandsRepositoryImpl implements BrandsRepository {
  // TODO: Inject API service
  // final ApiService _apiService;
  // BrandsRepositoryImpl(this._apiService);

  @override
  Future<List<BrandModel>> getAllBrands() async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/brands');
      // return (response.data['data'] as List)
      //     .map((json) => BrandModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get brands: $e');
    }
  }

  @override
  Future<BrandModel?> getBrandById(String brandId) async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/brands/$brandId');
      // return BrandModel.fromJson(response.data['data']);

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get brand: $e');
    }
  }

  @override
  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/brands/$brandId/products');
      // return (response.data['data'] as List)
      //     .map((json) => ProductModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get brand products: $e');
    }
  }
}
