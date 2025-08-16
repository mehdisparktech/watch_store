import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/features/wishlist/data/model/wishlist_model.dart';
import 'package:watch_store/services/api/api_service.dart';
import 'package:watch_store/services/storage/storage_services.dart';

abstract class WishlistRepository {
  Future<List<BookmarkModel>> getBookmarks();
}

class WishlistRepositoryImpl implements WishlistRepository {
  @override
  Future<List<BookmarkModel>> getBookmarks() async {
    final response = await ApiService.get(
      ApiEndPoint.bookmarks,
      header: {"Authorization": "Bearer ${LocalStorage.token}"},
    );
    if (response.isSuccess) {
      final data = Map<String, dynamic>.from(response.data);
      final list = (data['data'] as List? ?? []);
      return list
          .map((e) => BookmarkModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }
}
