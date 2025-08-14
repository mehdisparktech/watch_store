import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/drawer/common_drawer.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/utils/constants/app_string.dart';

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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildBrabdsCard("Rolex", "100", AppImages.availableWatch);
      },
    );
  }

  Widget _buildBrabdsCard(String brandName, String watchCount, String image) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.brands, arguments: brandName);
      },
      child: Container(
        width: Get.width * 0.9,
        height: 185.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
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
