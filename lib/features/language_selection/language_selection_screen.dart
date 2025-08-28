import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/languages/language_controller.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/utils/constants/app_text_style.dart';
import 'package:watch_store/utils/extensions/extension.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final LanguageController languageController = Get.find<LanguageController>();
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              50.height,
              // Logo
              CommonImage(
                imageSrc: AppImages.logoSpanish,
                height: 80.h,
                width: 200.w,
              ),
              60.height,

              // Welcome Text
              CommonText(
                text:
                    selectedLanguage == 'English'
                        ? 'Welcome to Watch Store'
                        : 'Bienvenido a Watch Store',
                style: AppTextStyle.title.copyWith(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),

              20.height,

              CommonText(
                text:
                    selectedLanguage == 'English'
                        ? 'Please select your preferred language'
                        : 'Por favor selecciona tu idioma preferido',
                style: AppTextStyle.body.copyWith(fontSize: 16.sp),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),

              80.height,

              // Language Options
              _buildLanguageOption('English', '🇺🇸', 'English'),

              20.height,

              _buildLanguageOption('Español', '🇪🇸', 'Spanish'),

              const Spacer(),

              // Continue Button
              Container(
                width: double.infinity,
                height: 56.h,
                margin: EdgeInsets.only(bottom: 40.h),
                child: ElevatedButton(
                  onPressed: _onContinuePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socialIconBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: CommonText(
                    text:
                        selectedLanguage == 'English'
                            ? 'Continue'
                            : 'Continuar',
                    style: AppTextStyle.body.copyWith(
                      color: AppColors.buttonText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String languageName, String flag, String value) {
    bool isSelected = selectedLanguage == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = value;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.socialIconBackground.withOpacity(0.1)
                  : Colors.transparent,
          border: Border.all(
            color:
                isSelected
                    ? AppColors.socialIconBackground
                    : AppColors.white.withOpacity(0.3),
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 32.sp)),
            20.width,
            Expanded(
              child: CommonText(
                text: languageName,
                style: AppTextStyle.body.copyWith(
                  fontSize: 18.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color:
                      isSelected
                          ? AppColors.socialIconBackground
                          : AppColors.white,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.socialIconBackground,
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }

  void _onContinuePressed() async {
    // Change the app language
    await languageController.changeLanguage(
      selectedLanguage == 'English' ? 'English' : 'Español',
    );

    // Mark that language has been selected (first time setup completed)
    await languageController.markLanguageAsSelected();

    // Navigate to appropriate onboarding screen
    if (selectedLanguage == 'English') {
      Get.offAllNamed(AppRoutes.onboarding);
    } else {
      Get.offAllNamed(AppRoutes.onboardingSpanish);
    }
  }
}
