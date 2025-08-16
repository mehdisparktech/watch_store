import 'package:flutter/material.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/utils/constants/app_text_style.dart';
import 'package:watch_store/utils/extensions/extension.dart';
import '../../../config/route/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/app_string.dart';
import '../../component/button/common_button.dart';
import '../../component/image/common_image.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                CommonImage(
                  imageSrc: AppImages.splash,
                  size: Get.height * 0.6,
                  fill: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 375.w,
                    height: 182.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.white,
                          Colors.white.withValues(alpha: 0.8),
                          Colors.white.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CommonText(
              text: AppString.splashTitle,
              style: AppTextStyle.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              left: 38.w,
              right: 38.w,
            ),
            CommonText(
              text: AppString.splashDescription,
              style: AppTextStyle.body,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              left: 55.w,
              right: 55.w,
            ),
            CommonButton(
              titleText: AppString.getStarted,
              onTap: () {
                Get.toNamed(AppRoutes.signIn);
              },
            ),
            20.height,
          ],
        ),
      ),
    );
  }
}
