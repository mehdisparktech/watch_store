import 'package:get/get.dart';
import 'package:watch_store/features/home/data/model/brand_model.dart';
import 'package:watch_store/features/home/repository/home_repository.dart';
import '../../../../utils/enum/enum.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepositoryImpl();

  Status status = Status.completed;
  List<HomeBrandModel> brands = [];
  bool isLoading = false;
  int currentPage = 1;
  bool hasMore = true;

  Future<void> loadBrands({bool refresh = false}) async {
    if (isLoading) return;
    if (refresh) {
      currentPage = 1;
      hasMore = true;
      brands.clear();
    }

    isLoading = true;
    status = Status.loading;
    update();

    try {
      final fetched = await _homeRepository.getBrands(
        page: currentPage,
        limit: 10,
      );
      if (fetched.isEmpty) {
        hasMore = false;
      } else {
        brands.addAll(fetched);
        currentPage++;
      }
      status = Status.completed;
    } catch (_) {
      status = Status.error;
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    loadBrands();
    super.onInit();
  }
}
