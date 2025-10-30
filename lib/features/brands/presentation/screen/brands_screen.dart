import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/drawer/common_drawer.dart';
import 'package:watch_store/component/text_field/common_text_field.dart';
import 'package:get/get.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/features/brands/presentation/controller/brands_controller.dart';
import 'package:watch_store/features/brands/presentation/widgets/watch_card.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import 'package:watch_store/utils/constants/app_icons.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/utils/enum/enum.dart';

class BrandsScreen extends StatelessWidget {
  final String title;
  final String categoryId;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BrandsScreen({super.key, this.title = 'Brands', required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        title: title,
        subTitle: true,
        profileImageUrl: ApiEndPoint.imageUrl + LocalStorage.myImage,
        onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: CommonDrawer(profileImage: AppImages.availableWatch),
      body: GetBuilder<BrandsController>(
        init: BrandsController(categoryId),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CommonTextField(
                    hintText: 'Search...',
                    controller: controller.searchController,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: CommonImage(imageSrc: AppIcons.search, size: 24),
                    ),
                    suffixIcon:
                        controller.searchQuery.isNotEmpty
                            ? IconButton(
                              onPressed: controller.clearSearch,
                              icon: Icon(Icons.clear, size: 20),
                            )
                            : null,
                    paddingVertical: 16,
                  ),
                ),
                if (controller.isLoading)
                  const Expanded(
                    child: Center(child: CupertinoActivityIndicator()),
                  ),
                if (!controller.isLoading && controller.status == Status.error)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('No Watches found'),
                          8.verticalSpace,
                          // ElevatedButton(
                          //   onPressed: () => controller.loadProducts(),
                          //   child: const Text('Retry'),
                          // ),
                        ],
                      ),
                    ),
                  ),
                if (!controller.isLoading)
                  Expanded(
                    child:
                        controller.filteredProducts.isEmpty
                            ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                  8.verticalSpace,
                                  Text(
                                    controller.searchQuery.isNotEmpty
                                        ? 'No watches found for "${controller.searchQuery}"'
                                        : 'No watches available',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  if (controller.searchQuery.isNotEmpty) ...[
                                    8.verticalSpace,
                                    TextButton(
                                      onPressed: controller.clearSearch,
                                      child: Text('Clear Search'),
                                    ),
                                  ],
                                ],
                              ),
                            )
                            : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16.0,
                                    mainAxisSpacing: 16.0,
                                  ),
                              itemCount: controller.filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product =
                                    controller.filteredProducts[index];
                                return WatchCard(
                                  watch: product,
                                  addBookmark: controller.addBookmark,
                                  removeBookmark: controller.removeBookmark,
                                  isFavorite: controller.bookmarks[index],
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
