import 'package:get/get.dart';
import 'package:watch_store/features/FAQ/presentation/screens/faq_screen.dart';
import 'package:watch_store/features/brands/presentation/screen/brands_screen.dart';
import 'package:watch_store/features/brands/presentation/screen/watch_detail_screen.dart';
import 'package:watch_store/features/home/presentation/screen/home_screen.dart';
import 'package:watch_store/features/news/presenation/screens/news_screen.dart';
import 'package:watch_store/features/wishlist/screen/wishlist_detail_screen.dart';
import 'package:watch_store/features/wishlist/screen/wishlist_screen.dart';
import '../../features/auth/change_password/presentation/screen/change_password_screen.dart';
import '../../features/auth/forgot password/presentation/screen/create_password.dart';
import '../../features/auth/forgot password/presentation/screen/forgot_password.dart';
import '../../features/auth/forgot password/presentation/screen/verify_screen.dart';
import '../../features/auth/sign in/presentation/screen/sign_in_screen.dart';
import '../../features/auth/sign up/presentation/screen/sign_up_screen.dart';
import '../../features/auth/sign up/presentation/screen/verify_user.dart';
import '../../features/message/presentation/screen/chat_screen.dart';
import '../../features/message/presentation/screen/message_screen.dart';
import '../../features/notifications/presentation/screen/notifications_screen.dart';
import '../../features/onboarding_screen/onboarding_screen.dart';
import '../../features/profile/presentation/screen/edit_profile.dart';
import '../../features/profile/presentation/screen/profile_screen.dart';
import '../../features/setting/presentation/screen/privacy_policy_screen.dart';
import '../../features/setting/presentation/screen/setting_screen.dart';
import '../../features/setting/presentation/screen/terms_of_services_screen.dart';
import '../../features/splash/splash_screen.dart';

class AppRoutes {
  static const String test = "/test_screen.dart";
  static const String splash = "/splash_screen.dart";
  static const String onboarding = "/onboarding_screen.dart";
  static const String signUp = "/sign_up_screen.dart";
  static const String verifyUser = "/verify_user.dart";
  static const String signIn = "/sign_in_screen.dart";
  static const String forgotPassword = "/forgot_password.dart";
  static const String verifyEmail = "/verify_screen.dart";
  static const String createPassword = "/create_password.dart";
  static const String changePassword = "/change_password_screen.dart";
  static const String notifications = "/notifications_screen.dart";
  static const String chat = "/chat_screen.dart";
  static const String message = "/message_screen.dart";
  static const String profile = "/profile_screen.dart";
  static const String editProfile = "/edit_profile.dart";
  static const String privacyPolicy = "/privacy_policy_screen.dart";
  static const String termsOfServices = "/terms_of_services_screen.dart";
  static const String setting = "/setting_screen.dart";
  static const String home = "/home_screen.dart";
  static const String brands = "/brands_screen.dart";
  static const String watchDetail = "/watch_detail_screen.dart";
  static const String news = "/news_screen.dart";
  static const String faq = "/faq_screen.dart";
  static const String wishlist = "/wishlist_screen.dart";
  static const String wishlistDetail = "/wishlist_detail_screen.dart";

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: verifyUser, page: () => const VerifyUser()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: verifyEmail, page: () => const VerifyScreen()),
    GetPage(name: createPassword, page: () => CreatePassword()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),
    GetPage(name: notifications, page: () => const NotificationScreen()),
    GetPage(name: chat, page: () => ChatListScreen()),
    GetPage(
      name: message,
      page: () => MessageScreen(isItemChat: Get.arguments),
    ),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: editProfile, page: () => EditProfile()),
    GetPage(name: privacyPolicy, page: () => const PrivacyPolicyScreen()),
    GetPage(name: termsOfServices, page: () => const TermsOfServicesScreen()),
    GetPage(name: setting, page: () => const SettingScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: brands, page: () => BrandsScreen(title: Get.arguments)),
    GetPage(
      name: watchDetail,
      page: () => WatchDetailScreen(watch: Get.arguments),
    ),
    GetPage(name: news, page: () => NewsScreen()),
    GetPage(name: faq, page: () => FAQScreen()),
    GetPage(name: wishlist, page: () => WishlistScreen()),
    GetPage(
      name: wishlistDetail,
      page: () => WishlistDetailScreen(watch: Get.arguments),
    ),
  ];
}
