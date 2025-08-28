import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../data/model/auth_response_model.dart';
import '../../../repository/auth_repository.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../../services/storage/storage_keys.dart';

class SignInController extends GetxController {
  /// Sign in Button Loading variable
  bool isLoading = false;

  /// Sign in form key , help for Validation
  final formKey = GlobalKey<FormState>();

  /// email and password Controller here
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? 'user@gmail.com' : '',
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'user@123' : "",
  );

  /// Auth repository
  late final AuthRepository _authRepository;

  @override
  void onInit() {
    super.onInit();
    _authRepository = AuthRepositoryImpl(baseUrl: ApiEndPoint.baseUrl);
  }

  /// Sign in Api call here
  Future<void> signInUser() async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    update();

    try {
      final request = LoginRequestModel(
        email: emailController.text,
        password: passwordController.text,
      );

      final response = await _authRepository.login(request);

      if (response.success) {
        // Save user data
        if (response.user != null) {
          LocalStorage.userId = response.user!.id ?? "";
          LocalStorage.myImage = response.user!.profileImage ?? "";
          LocalStorage.myName = response.user!.name ?? "";
          LocalStorage.myEmail = response.user!.email ?? "";
          LocalStorage.enterprise = response.enterprise ?? "";
          LocalStorage.isLogIn = true;

          // Debug log to verify enterprise data
          print("Enterprise data saved: ${LocalStorage.enterprise}");

          // Save to persistent storage
          LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
          LocalStorage.setString(LocalStorageKeys.userId, LocalStorage.userId);
          LocalStorage.setString(
            LocalStorageKeys.myImage,
            LocalStorage.myImage,
          );
          LocalStorage.setString(LocalStorageKeys.myName, LocalStorage.myName);
          LocalStorage.setString(
            LocalStorageKeys.myEmail,
            LocalStorage.myEmail,
          );
          LocalStorage.setString(
            LocalStorageKeys.enterprise,
            LocalStorage.enterprise,
          );
        }

        // Navigate to home screen
        Get.offAllNamed(AppRoutes.home);

        // Clear controllers
        emailController.clear();
        passwordController.clear();
      } else {
        Get.snackbar("Error", response.message ?? "Login failed");
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
