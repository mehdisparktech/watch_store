import '../data/model/news_model.dart';

abstract class NewsRepository {
  Future<List<NewsModel>> getNews({int page = 1, int limit = 10});
  Future<NewsModel?> getNewsById(String newsId);
  Future<List<NewsModel>> getNewsByCategory(String category);
  Future<List<String>> getNewsCategories();
  Future<List<NewsModel>> searchNews(String query);
}

class NewsRepositoryImpl implements NewsRepository {
  // TODO: Inject API service
  // final ApiService _apiService;
  // NewsRepositoryImpl(this._apiService);

  @override
  Future<List<NewsModel>> getNews({int page = 1, int limit = 10}) async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/news', queryParameters: {
      //   'page': page,
      //   'limit': limit,
      // });
      // return (response.data['data'] as List)
      //     .map((json) => NewsModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get news: $e');
    }
  }

  @override
  Future<NewsModel?> getNewsById(String newsId) async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/news/$newsId');
      // return NewsModel.fromJson(response.data['data']);

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get news by id: $e');
    }
  }

  @override
  Future<List<NewsModel>> getNewsByCategory(String category) async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/news/category/$category');
      // return (response.data['data'] as List)
      //     .map((json) => NewsModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get news by category: $e');
    }
  }

  @override
  Future<List<String>> getNewsCategories() async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/news/categories');
      // return (response.data['data'] as List)
      //     .map((json) => json['name'].toString())
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get news categories: $e');
    }
  }

  @override
  Future<List<NewsModel>> searchNews(String query) async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/news/search', queryParameters: {'q': query});
      // return (response.data['data'] as List)
      //     .map((json) => NewsModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to search news: $e');
    }
  }
}
