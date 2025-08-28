import 'package:get/get.dart';
import '../../data/model/news_model.dart';
import '../../repository/news_repository.dart';
import '../../../../utils/enum/enum.dart';

class NewsController extends GetxController {
  // Repository injection
  final NewsRepository _newsRepository = Get.find<NewsRepository>();

  // State variables
  Status status = Status.completed;
  List<NewsModel> newsList = [];
  int currentPage = 1;
  int totalPages = 1;
  bool hasMoreData = true;
  bool isLoading = false;

  // Load news data
  Future<void> getNews({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      hasMoreData = true;
      newsList.clear();
    }

    if (!hasMoreData || isLoading) return;

    isLoading = true;
    status = Status.loading;
    update();

    try {
      final news = await _newsRepository.getNews(page: currentPage, limit: 10);

      if (news.isEmpty) {
        hasMoreData = false;
      } else {
        newsList.addAll(news);
        currentPage++;
      }

      status = Status.completed;
    } catch (e) {
      status = Status.error;
    } finally {
      isLoading = false;
      update();
    }
  }

  // Load more news when scrolling
  void loadMore() {
    if (!isLoading && hasMoreData) {
      getNews();
    }
  }

  // Initialize controller
  @override
  void onInit() {
    getNews();
    super.onInit();
  }
}
