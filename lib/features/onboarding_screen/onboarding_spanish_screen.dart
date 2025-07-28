import 'package:flutter/material.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_text_style.dart';
import 'package:watch_store/utils/extensions/extension.dart';
import '../../../config/route/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/app_string.dart';
import '../../component/button/common_button.dart';
import '../../component/image/common_image.dart';

class OnboardingSpanishScreen extends StatelessWidget {
  const OnboardingSpanishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 50.h),
            CommonImage(
              imageSrc: AppImages.logoSpanish,
              height: 50.h,
              width: 250.w,
            ),
            Column(
              children: [
                CommonText(
                  text: AppString.splashTitle,
                  style: AppTextStyle.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  left: 38.w,
                  right: 38.w,
                ),
                30.height,
                CommonText(
                  text: AppString.splashDescription,
                  style: AppTextStyle.body,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  left: 55.w,
                  right: 55.w,
                ),
              ],
            ),
            CommonButton(
              titleText: AppString.getStarted,
              buttonColor: AppColors.socialIconBackground,
              titleColor: AppColors.buttonText,
              onTap: () {
                Get.toNamed(AppRoutes.signIn);
              },
            ),
          ],
        ),
      ),
    );
  }
}
