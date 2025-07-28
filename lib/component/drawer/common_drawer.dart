import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/button/common_button.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_icons.dart';
import 'package:watch_store/utils/constants/app_string.dart';

class CommonDrawer extends StatelessWidget {
  final String profileImage;
  final String userName;
  final String companyName;
  final VoidCallback? onLogout;

  const CommonDrawer({
    Key? key,
    required this.profileImage,
    this.userName = "Mike Joe",
    this.companyName = "Raconli Group",
    this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: Column(
        children: [
          // Profile Section
          Container(
            padding: EdgeInsets.only(top: 60.h, bottom: 30.h),
            child: Column(
              children: [
                // Profile Image
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.setting);
                      },
                      child: CommonImage(imageSrc: AppIcons.settings, size: 24),
                    ),
                    CircleAvatar(
                      radius: 40.r,
                      backgroundImage: AssetImage(profileImage),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.editProfile);
                      },
                      child: CommonImage(imageSrc: AppIcons.edit, size: 24),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                // User Name
                CommonText(
                  text: userName,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  fontFamily: 'PlayfairDisplay',
                ),
                SizedBox(height: 5.h),
                // Company
                CommonText(
                  text: companyName,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withOpacity(0.7),
                  fontFamily: 'PlayfairDisplay',
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: Column(
              children: [
                _buildMenuItem("Chat", AppRoutes.chat),
                _buildMenuItem("Catalogue", AppRoutes.home),
                _buildMenuItem("Wishlist", AppRoutes.wishlist),
                _buildMenuItem("News", AppRoutes.news),
                _buildMenuItem("FAQ", AppRoutes.faq),
              ],
            ),
          ),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 45),
            child: CommonButton(
              titleText: AppString.logOut,
              buttonColor: AppColors.socialIconBackground,
              onTap:
                  onLogout ??
                  () {
                    Get.offAllNamed(AppRoutes.signIn);
                  },
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, String route, {dynamic arguments}) {
    return ListTile(
      title: CommonText(
        text: title,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
        fontFamily: 'PlayfairDisplay',
      ),
      onTap: () {
        Get.back();
        if (route.isNotEmpty) {
          Get.toNamed(route, arguments: arguments);
        }
      },
    );
  }
}
