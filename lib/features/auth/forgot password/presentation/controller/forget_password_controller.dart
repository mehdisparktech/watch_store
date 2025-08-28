import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../config/route/app_routes.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../data/model/auth_response_model.dart';
import '../../../repository/auth_repository.dart';

class ForgetPasswordController extends GetxController {
  /// Loading for forget password
  bool isLoadingEmail = false;

  /// Loading for Verify OTP
  bool isLoadingVerify = false;

  /// Loading for Creating New Password
  bool isLoadingReset = false;

  /// this is ForgetPassword Token , need to verification
  String verifyToken = '';

  /// this is timer , help to resend OTP send time
  int start = 0;
  Timer? _timer;
  String time = "00:00";

  /// here all Text Editing Controller
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? "user@gmail.com" : '',
  );
  TextEditingController otpController = TextEditingController(
    text: kDebugMode ? '123456' : '',
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );
  TextEditingController confirmPasswordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );

  /// Repository
  late final AuthRepository _authRepository;

  /// create Forget Password Controller instance
  static ForgetPasswordController get instance =>
      Get.put(ForgetPasswordController());

  @override
  void onInit() {
    super.onInit();
    _authRepository = AuthRepositoryImpl(baseUrl: ApiEndPoint.baseUrl);
  }

  /// Start Timer for OTP
  void startTimer() {
    start = 120; // 2 minutes
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start == 0) {
        _timer?.cancel();
      } else {
        start--;
        time = getTimeString(start);
        update();
      }
    });
  }

  /// Get Time String
  String getTimeString(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  /// Forget Password Api Call
  Future<void> forgotPasswordRepo() async {
    isLoadingEmail = true;
    update();

    try {
      final request = ForgotPasswordRequestModel(email: emailController.text);
      final response = await _authRepository.forgotPassword(request);

      if (response.success) {
        Get.toNamed(AppRoutes.verifyEmail);
      } else {
        Get.snackbar("Error", response.message ?? "Failed to send OTP");
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
    } finally {
      isLoadingEmail = false;
      update();
    }
  }

  /// Verify OTP Api Call
  Future<void> verifyOtpRepo() async {
    isLoadingVerify = true;
    update();

    try {
      final request = VerifyEmailRequestModel(
        email: emailController.text,
        oneTimeCode: int.parse(otpController.text),
      );

      final response = await _authRepository.verifyEmail(request);

      if (response.success) {
        verifyToken = response.token ?? '';
        Get.toNamed(AppRoutes.createPassword);
      } else {
        Get.snackbar("Error", response.message ?? "Verification failed");
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
    } finally {
      isLoadingVerify = false;
      update();
    }
  }

  /// Create New Password Api Call
  Future<void> resetPasswordRepo() async {
    isLoadingReset = true;
    update();

    try {
      final request = ResetPasswordRequestModel(
        newPassword: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      final response = await (_authRepository as AuthRepositoryImpl)
          .resetPassword(request, verifyToken);

      if (response.success) {
        Get.offAllNamed(AppRoutes.signIn);
        emailController.clear();
        otpController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
      } else {
        Get.snackbar("Error", response.message ?? "Password reset failed");
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
    } finally {
      isLoadingReset = false;
      update();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
