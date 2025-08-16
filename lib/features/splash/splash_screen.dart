import 'package:flutter/material.dart';
import 'package:watch_store/utils/extensions/extension.dart';
import '../../../config/route/app_routes.dart';
import 'package:get/get.dart';
import '../../../utils/constants/app_images.dart';
import '../../component/image/common_image.dart';
import '../../../services/storage/storage_services.dart';
import '../../../config/languages/language_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checkLoginStatus();
    super.initState();
  }

  Future<void> _checkLoginStatus() async {
    // স্প্ল্যাশ স্ক্রিন দেখানোর জন্য কিছু সময় অপেক্ষা করুন
    await Future.delayed(const Duration(seconds: 3));

    try {
      // লোকাল স্টোরেজ থেকে সব ডেটা লোড করুন
      await LocalStorage.getAllPrefData();

      // Check if language has been selected before
      final languageSelected = LocalStorage.languageSelected;
      final token = LocalStorage.token;
      final isLoggedIn = LocalStorage.isLogIn;

      if (!languageSelected) {
        // First time user - show language selection
        Get.offAllNamed(AppRoutes.languageSelection);
      } else if (isLoggedIn && token.isNotEmpty) {
        // যদি ব্যবহারকারী লগইন থাকে এবং টোকেন থাকে, তাহলে হোম পেজে নিয়ে যান
        Get.offAllNamed(AppRoutes.home);
      } else {
        // Language already selected, but not logged in - go to appropriate onboarding
        // Try to get language controller, if not available use default
        try {
          final languageController = Get.find<LanguageController>();
          if (languageController.isSpanish) {
            Get.offAllNamed(AppRoutes.onboardingSpanish);
          } else {
            Get.offAllNamed(AppRoutes.onboarding);
          }
        } catch (e) {
          // If language controller not found, default to English onboarding
          Get.offAllNamed(AppRoutes.onboarding);
        }
      }
    } catch (e) {
      // If any error occurs, go to language selection as fallback
      Get.offAllNamed(AppRoutes.languageSelection);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          CommonImage(
            imageSrc: AppImages.watchStoreLogo,
            width: Get.width * 0.8,
            fill: BoxFit.cover,
          ).center,
    );
  }
}
