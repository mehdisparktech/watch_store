import 'package:get/get.dart';
import 'package:watch_store/features/wishlist/presentation/controller/wishlist_controller.dart';

import '../../features/auth/change_password/presentation/controller/change_password_controller.dart';
import '../../features/auth/forgot password/presentation/controller/forget_password_controller.dart';
import '../../features/auth/sign in/presentation/controller/sign_in_controller.dart';
import '../../features/auth/sign up/presentation/controller/sign_up_controller.dart';
import '../../features/auth/repository/auth_repository.dart';
import '../../features/message/presentation/controller/chat_controller.dart';
import '../../features/message/presentation/controller/message_controller.dart';
import '../../features/news/presenation/controller/news_controller.dart';
import '../../features/news/repository/news_repository.dart';
import '../../features/home/repository/home_repository.dart';
import '../../features/home/presentation/controller/home_controller.dart';
import '../../features/notifications/presentation/controller/notifications_controller.dart';
import '../../features/profile/presentation/controller/profile_controller.dart';
import '../../features/setting/presentation/controller/privacy_policy_controller.dart';
import '../../features/setting/presentation/controller/setting_controller.dart';
import '../../features/setting/presentation/controller/terms_of_services_controller.dart';
import '../../features/FAQ/repository/faq_repository.dart';
import '../../features/FAQ/presentation/controller/faq_controller.dart';
import '../languages/language_controller.dart';
import '../api/api_end_point.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    // Language Controller
    Get.put(LanguageController(), permanent: true);

    // Repositories
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(baseUrl: ApiEndPoint.baseUrl),
      fenix: true,
    );

    // News Repository
    Get.lazyPut<NewsRepository>(() => NewsRepositoryImpl(), fenix: true);
    // Home Repository
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(), fenix: true);

    // FAQ Repository
    Get.lazyPut<FAQRepository>(() => FAQRepositoryImpl(), fenix: true);

    // Auth Controllers
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => ForgetPasswordController(), fenix: true);
    Get.lazyPut(() => ChangePasswordController(), fenix: true);

    // Feature Controllers
    Get.lazyPut(() => NotificationsController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => MessageController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => SettingController(), fenix: true);
    Get.lazyPut(() => PrivacyPolicyController(), fenix: true);
    Get.lazyPut(() => TermsOfServicesController(), fenix: true);

    // FAQ Controller
    Get.lazyPut(() => FAQController(), fenix: true);

    // News Controller
    Get.lazyPut(() => NewsController(), fenix: true);
    // Home Controller
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => WishlistController(), fenix: true);

    // Note: BrandsController, BrandsCategoryController, and ProductDetailController
    // are not registered here because they require runtime parameters (brandId, categoryId, productId)
    // They should be instantiated when navigating to their respective screens
  }
}
