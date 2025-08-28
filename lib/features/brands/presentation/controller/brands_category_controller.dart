import 'package:get/get.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/features/brands/data/model/category_model.dart';
import 'package:watch_store/services/api/api_service.dart';
import 'package:watch_store/utils/enum/enum.dart';

class BrandsCategoryController extends GetxController {
  final String brandId;
  BrandsCategoryController(this.brandId);

  Status status = Status.completed;
  List<BrandCategoryModel> categories = [];

  Future<void> loadCategories() async {
    status = Status.loading;
    update();
    try {
      final response = await ApiService.get(
        "${ApiEndPoint.categories}/${ApiEndPoint.brands}/$brandId",
      );
      if (response.isSuccess) {
        final responseData = response.data['data'];
        final data = (responseData['data'] as List?) ?? [];
        categories =
            data
                .map(
                  (e) =>
                      BrandCategoryModel.fromApi(Map<String, dynamic>.from(e)),
                )
                .toList();
        status = Status.completed;
      } else {
        status = Status.error;
      }
    } catch (_) {
      status = Status.error;
    } finally {
      update();
    }
  }

  @override
  void onInit() {
    loadCategories();
    super.onInit();
  }
}
