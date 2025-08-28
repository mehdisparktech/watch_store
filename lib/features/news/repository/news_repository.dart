import '../../../services/api/api_service.dart';
import '../data/model/news_model.dart';

abstract class NewsRepository {
  Future<List<NewsModel>> getNews({int page = 1, int limit = 10});
}

class NewsRepositoryImpl implements NewsRepository {
  @override
  Future<List<NewsModel>> getNews({int page = 1, int limit = 10}) async {
    try {
      final response = await ApiService.get("news?page=$page&limit=$limit");

      if (response.isSuccess) {
        final newsResponse = NewsResponse.fromJson(
          Map<String, dynamic>.from(response.data),
        );
        return newsResponse.data.data;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to get news: $e');
    }
  }
}
