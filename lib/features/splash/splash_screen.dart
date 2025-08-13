import 'package:flutter/material.dart';
import 'package:watch_store/utils/extensions/extension.dart';
import '../../../config/route/app_routes.dart';
import 'package:get/get.dart';
import '../../../utils/constants/app_images.dart';
import '../../component/image/common_image.dart';
import '../../../services/storage/storage_services.dart';

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

    // লোকাল স্টোরেজ থেকে টোকেন এবং লগইন স্ট্যাটাস চেক করুন
    final token = LocalStorage.token;
    final isLoggedIn = LocalStorage.isLogIn;

    if (isLoggedIn && token.isNotEmpty) {
      // যদি ব্যবহারকারী লগইন থাকে এবং টোকেন থাকে, তাহলে হোম পেজে নিয়ে যান
      Get.offAllNamed(AppRoutes.home);
    } else {
      // অন্যথায় অনবোর্ডিং পেজে নিয়ে যান
      Get.offAllNamed(AppRoutes.onboardingSpanish);
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
