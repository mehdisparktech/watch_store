import '../data/model/faq_model.dart';

abstract class FAQRepository {
  Future<List<FAQModel>> getAllFAQs();
  Future<List<FAQModel>> getFAQsByCategory(String category);
  Future<List<FAQCategoryModel>> getFAQCategories();
  Future<List<FAQModel>> searchFAQs(String query);
}

class FAQRepositoryImpl implements FAQRepository {
  // TODO: Inject API service
  // final ApiService _apiService;
  // FAQRepositoryImpl(this._apiService);

  @override
  Future<List<FAQModel>> getAllFAQs() async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/faqs');
      // return (response.data['data'] as List)
      //     .map((json) => FAQModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get FAQs: $e');
    }
  }

  @override
  Future<List<FAQModel>> getFAQsByCategory(String category) async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/faqs/category/$category');
      // return (response.data['data'] as List)
      //     .map((json) => FAQModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get FAQs by category: $e');
    }
  }

  @override
  Future<List<FAQCategoryModel>> getFAQCategories() async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/faqs/categories');
      // return (response.data['data'] as List)
      //     .map((json) => FAQCategoryModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get FAQ categories: $e');
    }
  }

  @override
  Future<List<FAQModel>> searchFAQs(String query) async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/faqs/search', queryParameters: {'q': query});
      // return (response.data['data'] as List)
      //     .map((json) => FAQModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to search FAQs: $e');
    }
  }
}
