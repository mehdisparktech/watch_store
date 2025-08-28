import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/drawer/common_drawer.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/component/other_widgets/common_loader.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/features/home/presentation/controller/home_controller.dart';
import 'package:watch_store/features/profile/presentation/controller/profile_controller.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/utils/constants/app_string.dart';
import 'package:watch_store/utils/enum/enum.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (profileController) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: CommonAppBar(
            title: AppString.availableBrands,
            profileImageUrl:
                LocalStorage.myImage.isNotEmpty
                    ? ApiEndPoint.imageUrl + LocalStorage.myImage
                    : '',
            onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
          endDrawer: GetBuilder<ProfileController>(
            builder:
                (profileController) =>
                    CommonDrawer(profileImage: AppImages.availableWatch),
          ),
          body: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              if (controller.status == Status.loading &&
                  controller.brands.isEmpty) {
                return const CommonLoader();
              }
              if (controller.status == Status.error) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Failed to load brands'),
                      8.verticalSpace,
                      ElevatedButton(
                        onPressed: () => controller.loadBrands(refresh: true),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              return _buildBody(controller);
            },
          ),
        );
      },
    );
  }

  Widget _buildBody(HomeController controller) {
    return RefreshIndicator(
      onRefresh: () => controller.loadBrands(refresh: true),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        itemCount: controller.brands.length,
        itemBuilder: (context, index) {
          final brand = controller.brands[index];
          final name = brand.name ?? '';
          final count = brand.totalCategories?.toString() ?? '0';
          final imageUrl =
              (brand.image?.startsWith('http') ?? false)
                  ? brand.image!
                  : "${ApiEndPoint.imageUrl}${brand.image ?? ''}";
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildBrabdsCard(name, count, imageUrl, brand.id ?? ''),
          );
        },
      ),
    );
  }

  Widget _buildBrabdsCard(
    String brandName,
    String watchCount,
    String image,
    String brandId,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.brandsCategory, arguments: brandId);
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
