import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/features/brands/data/model/product_model.dart';
import 'package:watch_store/services/api/api_service.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import 'package:watch_store/utils/enum/enum.dart';

class BrandsController extends GetxController {
  final String categoryId;
  final List<bool> bookmarks = [];
  BrandsController(this.categoryId);

  Status status = Status.completed;
  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool isLoading = false;

  Future<void> loadProducts() async {
    ////status = Status.loading;
    isLoading = true;
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
        filteredProducts = List.from(products);
        bookmarks.clear();
        bookmarks.addAll(products.map((e) => e.isFavorite ?? false));
        isLoading = false;
      } else {
        isLoading = false;
      }
    } catch (_) {
      isLoading = false;
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
    loadProducts();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
