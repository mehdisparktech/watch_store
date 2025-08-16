import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/drawer/common_drawer.dart';
import 'package:watch_store/component/text_field/common_text_field.dart';
import 'package:get/get.dart';
import 'package:watch_store/features/brands/presentation/controller/brands_controller.dart';
import 'package:watch_store/features/brands/presentation/widgets/watch_card.dart';
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
        profileImageUrl: AppImages.profileImage,
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
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: CommonImage(imageSrc: AppIcons.search, size: 24),
                    ),
                    paddingVertical: 16,
                  ),
                ),
                if (controller.status == Status.loading &&
                    controller.products.isEmpty)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (controller.status == Status.error)
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
                if (controller.status != Status.loading &&
                    controller.status != Status.error)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async => controller.loadProducts(),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) {
                          final product = controller.products[index];
                          return WatchCard(
                            watch: product,
                            addBookmark: controller.addBookmark,
                            removeBookmark: controller.removeBookmark,
                          );
                        },
                      ),
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
