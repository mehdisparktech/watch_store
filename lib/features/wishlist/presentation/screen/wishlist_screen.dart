import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/drawer/common_drawer.dart';
import 'package:watch_store/component/text_field/common_text_field.dart';
import 'package:watch_store/features/brands/presentation/widgets/watch_card.dart'
    as brands;
import 'package:watch_store/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:watch_store/utils/constants/app_icons.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/utils/enum/enum.dart';

class WishlistScreen extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  WishlistScreen({super.key, this.title = 'Brands'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        title: 'Wishlist',
        subTitle: true,
        profileImageUrl: AppImages.profileImage,
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
                    hintText: 'Search...',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: CommonImage(imageSrc: AppIcons.search, size: 24),
                    ),
                    paddingVertical: 16,
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (_) {
                      if (controller.status == Status.loading &&
                          controller.products.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (controller.status == Status.error) {
                        return const Center(
                          child: Text('Failed to load bookmarks'),
                        );
                      }
                      if (controller.products.isEmpty) {
                        return const Center(child: Text('No bookmarks found'));
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
                            return brands.WatchCard(
                              watch: controller.products[index],
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
