import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/drawer/common_drawer.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/features/brands/presentation/controller/brands_category_controller.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/utils/constants/app_string.dart';
import 'package:watch_store/utils/enum/enum.dart';
import 'package:watch_store/config/api/api_end_point.dart';

class BrandsCategoryScreen extends StatelessWidget {
  BrandsCategoryScreen({super.key, required this.brandId});
  final String brandId;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        title: AppString.brandsCategory,
        profileImageUrl: AppImages.profileImage,
        onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: CommonDrawer(profileImage: AppImages.availableWatch),
      body: GetBuilder<BrandsCategoryController>(
        init: BrandsCategoryController(brandId),
        builder: (controller) {
          if (controller.status == Status.loading &&
              controller.categories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.status == Status.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No categories found'),
                  8.verticalSpace,
                  // ElevatedButton(
                  //   onPressed: () => controller.loadCategories(),
                  //   child: const Text('Retry'),
                  // ),
                ],
              ),
            );
          }
          return _buildBody(controller);
        },
      ),
    );
  }

  Widget _buildBody(BrandsCategoryController controller) {
    return RefreshIndicator(
      onRefresh: () async => controller.loadCategories(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          final imageUrl =
              (category.image?.startsWith('http') ?? false)
                  ? (category.image ?? '')
                  : "${ApiEndPoint.imageUrl}${category.image ?? ''}";
          return _buildBrabdsCard(
            category.name,
            category.totalProducts.toString(),
            imageUrl,
            category.id,
          );
        },
      ),
    );
  }

  Widget _buildBrabdsCard(
    String brandName,
    String watchCount,
    String image,
    String categoryId,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.brands,
          arguments: {'title': brandName, 'categoryId': categoryId},
        );
      },
      child: Container(
        width: Get.width * 0.9,
        height: 185.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.black.withValues(alpha: 0.0)],
                ),
              ),
            ),
            Positioned(
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: brandName,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    fontFamily: 'PlayfairDisplay',
                  ),
                  CommonText(
                    text: "$watchCount+ watches",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
