import 'package:get/get.dart';
import 'package:watch_store/features/brands/data/model/product_model.dart';
import 'package:watch_store/features/wishlist/repository/wishlist_repository.dart';
import 'package:watch_store/utils/enum/enum.dart';

class WishlistController extends GetxController {
  Status status = Status.completed;
  List<ProductModel> products = [];

  final WishlistRepository _repository = WishlistRepositoryImpl();

  Future<void> loadBookmarks() async {
    status = Status.loading;
    update();
    try {
      final bookmarks = await _repository.getBookmarks();
      products =
          bookmarks.map((b) => b.product).whereType<ProductModel>().toList();
      status = Status.completed;
    } catch (_) {
      status = Status.error;
    } finally {
      update();
    }
  }

  @override
  void onInit() {
    loadBookmarks();
    super.onInit();
  }
}
