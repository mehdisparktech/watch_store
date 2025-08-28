import 'package:get/get.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/features/brands/data/model/product_model.dart';
import 'package:watch_store/services/api/api_service.dart';
import 'package:watch_store/utils/enum/enum.dart';

class ProductDetailController extends GetxController {
  final String productId;
  ProductDetailController(this.productId);

  Status status = Status.loading;
  ProductModel? product;

  Future<void> loadProduct() async {
    status = Status.loading;
    update();
    try {
      final response = await ApiService.get(
        "${ApiEndPoint.products}/$productId",
      );
      if (response.isSuccess) {
        final data = Map<String, dynamic>.from(response.data);
        final productJson = Map<String, dynamic>.from(data['data'] ?? {});
        product = ProductModel.fromJson(productJson);
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
    loadProduct();
    super.onInit();
  }
}
