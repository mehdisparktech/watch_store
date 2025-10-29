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

  /// email and password Controller here
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? 'hehecoh793@inilas.com' : '',
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
    //if (!formKey.currentState!.validate()) return;

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
          LocalStorage.role = response.user!.role ?? "";
          LocalStorage.enterprise = response.enterprise ?? "";
          LocalStorage.isLogIn = true;

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
          LocalStorage.setString(LocalStorageKeys.role, LocalStorage.role);
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

  /// Sign in with Google
  void signInWithGoogle() {
    print("Sign in with Google");
    Get.snackbar("coming soon", "Sign in with Google");
  }

  /// Sign in with Facebook
  void signInWithFacebook() {
    print("Sign in with Facebook");
    Get.snackbar("coming soon", "Sign in with Facebook");
  }

  /// Sign in with Apple
  void signInWithApple() {
    print("Sign in with Apple");
    Get.snackbar("coming soon", "Sign in with Apple");
  }
}
