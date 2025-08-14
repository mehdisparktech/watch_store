import 'package:get/get.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/features/brands/data/model/product_model.dart';
import 'package:watch_store/services/api/api_service.dart';
import 'package:watch_store/utils/enum/enum.dart';

class BrandsController extends GetxController {
  final String categoryId;
  BrandsController(this.categoryId);

  Status status = Status.completed;
  List<ProductModel> products = [];

  Future<void> loadProducts() async {
    status = Status.loading;
    update();
    try {
      final response = await ApiService.get(
        "${ApiEndPoint.products}/$categoryId/products",
      );
      if (response.isSuccess) {
        final data = Map<String, dynamic>.from(response.data);
        final productsJson = (data['data']?['products'] as List?) ?? [];
        products =
            productsJson
                .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
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
    loadProducts();
    super.onInit();
  }
}
