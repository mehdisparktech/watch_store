import 'package:get/get.dart';
import '../presenation/controller/news_controller.dart';
import '../repository/news_repository.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    // Repository
    Get.lazyPut<NewsRepository>(() => NewsRepositoryImpl(), fenix: true);

    // Controller
    Get.lazyPut<NewsController>(() => NewsController(), fenix: true);
  }
}
