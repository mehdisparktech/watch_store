import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/button/common_button.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/component/pop_up/common_pop_menu.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/services/api/api_service.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import 'package:watch_store/utils/app_utils.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_icons.dart';
import 'package:watch_store/utils/constants/app_string.dart';

class CommonDrawer extends StatelessWidget {
  final String profileImage;
  final VoidCallback? onLogout;

  const CommonDrawer({super.key, required this.profileImage, this.onLogout});

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
                      backgroundColor: AppColors.socialIconBackground,
                      radius: 30.r,
                      child: ClipOval(
                        child: CommonImage(
                          imageSrc:
                              LocalStorage.myImage.isNotEmpty
                                  ? ApiEndPoint.imageUrl + LocalStorage.myImage
                                  : '',
                          width: 60.r,
                          height: 60.r,
                          fill: BoxFit.cover,
                        ),
                      ),
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
                  text: LocalStorage.myName,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  fontFamily: 'PlayfairDisplay',
                ),
                SizedBox(height: 5.h),
                // Company
                CommonText(
                  text: LocalStorage.enterprise,
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMenuItem(AppString.chat, AppRoutes.chat),
                  _buildMenuItem(AppString.catalogue, AppRoutes.home),
                  _buildMenuItem(AppString.wishlist, AppRoutes.wishlist),
                  _buildMenuItem(AppString.news, AppRoutes.news),
                  _buildMenuItem(AppString.faq, AppRoutes.faq),
                  _buildMenuItem(AppString.incentivos, AppRoutes.incentivos),
                  GestureDetector(
                    onTap: () {
                      deletePopUp(
                        controller: TextEditingController(),
                        onTap: () async {
                          var response = await ApiService.delete(
                            ApiEndPoint.deleteUser,
                            //body: {"password": TextEditingController().text},
                            header: {
                              "Authorization": "Bearer ${LocalStorage.token}",
                            },
                          );
                          if (response.statusCode == 200) {
                            await LocalStorage.removeAllPrefData();
                            Get.offAllNamed(AppRoutes.signIn);
                          } else {
                            Utils.errorSnackBar(
                              response.statusCode,
                              response.message,
                            );
                          }
                        },
                      );
                    },
                    child: CommonText(
                      text: AppString.deleteAccount,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                      fontFamily: 'PlayfairDisplay',
                      top: 20.h,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
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
                    LocalStorage.removeAllPrefData();
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
      onTap: () async {
        Get.back();
        if (route.isNotEmpty) {
          Get.toNamed(route, arguments: arguments);
        }
      },
    );
  }
}
