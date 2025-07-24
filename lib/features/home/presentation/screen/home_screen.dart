import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/button/common_button.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/utils/constants/app_string.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        title: AppString.availableBrands,
        profileImageUrl: AppImages.profileImage,
        onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: _buildSidebarMenu(),
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

  Widget _buildSidebarMenu() {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          // Profile Section
          Container(
            padding: EdgeInsets.only(top: 60.h, bottom: 30.h),
            child: Column(
              children: [
                // Profile Image
                CircleAvatar(
                  radius: 40.r,
                  backgroundImage: AssetImage(AppImages.availableWatch),
                ),
                SizedBox(height: 15.h),
                // User Name
                CommonText(
                  text: "Mike Joe",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                SizedBox(height: 5.h),
                // Company
                CommonText(
                  text: "Raconli Group",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withOpacity(0.7),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: Column(
              children: [
                _buildMenuItem("Chat"),
                _buildMenuItem("Catalogue"),
                _buildMenuItem("Wishlist"),
                _buildMenuItem("News"),
                _buildMenuItem("FAQ"),
              ],
            ),
          ),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 45),
            child: CommonButton(
              titleText: AppString.logOut,
              buttonColor: AppColors.socialIconBackground,
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title) {
    return ListTile(
      title: CommonText(
        text: title,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      onTap: () {
        Get.back();
        // Handle navigation based on title
        switch (title) {
          case "Chat":
            Get.toNamed(AppRoutes.chat);
            break;
          case "Catalogue":
            Get.toNamed(AppRoutes.brands, arguments: " All Brands");
            break;
          case "Wishlist":
            // Navigate to wishlist screen
            break;
          case "News":
            // Navigate to news screen
            break;
          case "FAQ":
            // Navigate to FAQ screen
            break;
        }
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
                  ),
                  CommonText(
                    text: "$watchCount+ watches",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
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
