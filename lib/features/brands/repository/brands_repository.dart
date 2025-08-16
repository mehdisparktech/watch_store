import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/services/api/api_service.dart';

import '../data/model/brand_model.dart';
import '../data/model/product_model.dart';

abstract class BrandsRepository {
  Future<List<BrandModel>> getAllBrands();
  Future<BrandModel?> getBrandById(String brandId);
  Future<List<ProductModel>> getBrandProducts(String brandId);
}

class BrandsRepositoryImpl implements BrandsRepository {
  @override
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final response = await ApiService.get(ApiEndPoint.brands);
      return (response.data['data'] as List)
          .map((json) => BrandModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get brands: $e');
    }
  }

  @override
  Future<BrandModel?> getBrandById(String brandId) async {
    try {
      final response = await ApiService.get("${ApiEndPoint.brands}/$brandId");
      return BrandModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to get brand: $e');
    }
  }

  @override
  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    try {
      final response = await ApiService.get(
        "${ApiEndPoint.brands}/$brandId/products",
      );
      return (response.data['data'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get brand products: $e');
    }
  }
}
