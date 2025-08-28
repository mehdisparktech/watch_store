import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/features/brands/data/model/product_model.dart';
import 'package:watch_store/features/wishlist/repository/wishlist_repository.dart';
import 'package:watch_store/services/api/api_service.dart';
import 'package:watch_store/services/storage/storage_services.dart';

class WishlistController extends GetxController {
  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool isLoading = false;
  final WishlistRepository _repository = WishlistRepositoryImpl();

  Future<void> loadBookmarks() async {
    isLoading = true;
    update();
    try {
      final bookmarks = await _repository.getBookmarks();
      products =
          bookmarks.map((b) => b.product).whereType<ProductModel>().toList();
      isLoading = false;
    } catch (_) {
      isLoading = false;
    } finally {
      update();
    }
  }

  Future<void> removeBookmark(String productId) async {
    try {
      final response = await ApiService.delete(
        "${ApiEndPoint.bookmarks}/$productId",
        header: {"Authorization": "Bearer ${LocalStorage.token}"},
      );
      if (response.isSuccess) {
        loadBookmarks();
        Get.snackbar('Success', 'Product removed from wishlist');
      } else {
        Get.snackbar('Error', 'Product not removed from wishlist');
      }
    } catch (_) {
      Get.snackbar('Error', 'Product not removed from wishlist');
    }
  }

  void searchProducts(String query) {
    searchQuery = query.toLowerCase().trim();
    if (searchQuery.isEmpty) {
      filteredProducts = List.from(products);
    } else {
      filteredProducts =
          products.where((product) {
            final name = product.name?.toLowerCase() ?? '';
            final brandName = product.brandName?.toLowerCase() ?? '';
            final description = product.description?.toLowerCase() ?? '';

            return name.contains(searchQuery) ||
                brandName.contains(searchQuery) ||
                description.contains(searchQuery);
          }).toList();
    }
    update();
  }

  void clearSearch() {
    searchController.clear();
    searchQuery = '';
    filteredProducts = List.from(products);

    update();
  }

  @override
  void onInit() {
    searchController.addListener(() {
      searchProducts(searchController.text);
    });
    loadBookmarks();
    super.onInit();
  }
}
