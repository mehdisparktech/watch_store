import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/drawer/common_drawer.dart';
import 'package:watch_store/component/text_field/common_text_field.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/features/wishlist/presentation/widgets/watch_card.dart';
import 'package:watch_store/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import 'package:watch_store/utils/constants/app_icons.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/utils/constants/app_string.dart';

class WishlistScreen extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  WishlistScreen({super.key, this.title = 'Brands'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        title: AppString.wishlist,
        subTitle: true,
        profileImageUrl: ApiEndPoint.imageUrl + LocalStorage.myImage,
        onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: CommonDrawer(profileImage: AppImages.availableWatch),
      body: GetBuilder<WishlistController>(
        init: WishlistController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CommonTextField(
                    controller: controller.searchController,
                    hintText: 'Search...',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: CommonImage(imageSrc: AppIcons.search, size: 24),
                    ),
                    paddingVertical: 16,
                    suffixIcon:
                        controller.searchQuery.isNotEmpty
                            ? IconButton(
                              onPressed: controller.clearSearch,
                              icon: Icon(Icons.clear, size: 20),
                            )
                            : null,
                  ),
                ),
                if (controller.isLoading)
                  const Expanded(
                    child: Center(child: CupertinoActivityIndicator()),
                  ),
                if (!controller.isLoading)
                  Expanded(
                    child: Builder(
                      builder: (_) {
                        if (controller.isLoading &&
                            controller.products.isEmpty) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }

                        if (controller.products.isEmpty) {
                          return const Center(
                            child: Text('No bookmarks found'),
                          );
                        }
                        return RefreshIndicator(
                          onRefresh: () => controller.loadBookmarks(),
                          child: GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0,
                                ),
                            itemCount: controller.products.length,
                            itemBuilder: (context, index) {
                              return WatchCard(
                                watch: controller.products[index],
                                onPressed:
                                    () => controller.removeBookmark(
                                      controller.products[index].id ?? '',
                                    ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
