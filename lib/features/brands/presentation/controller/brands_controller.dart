import 'package:get/get.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/features/brands/data/model/product_model.dart';
import 'package:watch_store/services/api/api_service.dart';
import 'package:watch_store/services/storage/storage_services.dart';
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

  Future<void> addBookmark(String productId) async {
    try {
      final response = await ApiService.post(
        ApiEndPoint.bookmarks,
        body: {"productId": productId},
        header: {"Authorization": "Bearer ${LocalStorage.token}"},
      );
      if (response.isSuccess) {
        loadProducts();
        Get.snackbar('Success', 'Product added to wishlist');
      } else {
        Get.snackbar('Error', 'Product not added to wishlist');
      }
    } catch (_) {
      Get.snackbar('Error', 'Product not added to wishlist');
    }
  }

  Future<void> removeBookmark(String productId) async {
    try {
      final response = await ApiService.delete(
        "${ApiEndPoint.bookmarks}/$productId",
        header: {"Authorization": "Bearer ${LocalStorage.token}"},
      );
      if (response.isSuccess) {
        loadProducts();
        Get.snackbar('Success', 'Product removed from wishlist');
      } else {
        Get.snackbar('Error', 'Product not removed from wishlist');
      }
    } catch (_) {
      Get.snackbar('Error', 'Product not removed from wishlist');
    }
  }

  @override
  void onInit() {
    loadProducts();
    super.onInit();
  }
}
