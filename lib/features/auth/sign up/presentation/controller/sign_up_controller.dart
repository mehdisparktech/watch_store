import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:watch_store/utils/helpers/other_helper.dart';

import '../../../../../config/route/app_routes.dart';
import '../../../../../services/storage/storage_keys.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../../utils/app_utils.dart';
import '../../../data/model/auth_response_model.dart';
import '../../../repository/auth_repository.dart';

class SignUpController extends GetxController {
  /// Sign Up Form Key
  final signUpFormKey = GlobalKey<FormState>();

  bool isPopUpOpen = false;
  bool isLoading = false;
  bool isLoadingVerify = false;

  Timer? _timer;
  int start = 0;

  String time = "";

  List selectedOption = ["User", "Consultant"];

  String selectRole = "User";
  String countryCode = "+880";
  String? image;

  String userEmail = '';

  late final AuthRepository _authRepository;

  static SignUpController get instance => Get.find<SignUpController>();

  TextEditingController nameController = TextEditingController(
    text: kDebugMode ? "Namimul Hassan" : "",
  );
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? "developernaimul00@gmail.com" : '',
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );
  TextEditingController confirmPasswordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );
  TextEditingController numberController = TextEditingController(
    text: kDebugMode ? '1865965581' : '',
  );
  TextEditingController otpController = TextEditingController(
    text: kDebugMode ? '123456' : '',
  );

  @override
  void onInit() {
    super.onInit();
    _authRepository = AuthRepositoryImpl(baseUrl: ApiEndPoint.baseUrl);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  onCountryChange(Country value) {
    countryCode = value.dialCode.toString();
  }

  setSelectedRole(value) {
    selectRole = value;
    update();
  }

  openGallery() async {
    image = await OtherHelper.openGallery();
    update();
  }

  signUpUser() async {
    if (!signUpFormKey.currentState!.validate()) return;

    isLoading = true;
    update();

    try {
      final request = RegisterRequestModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: numberController.text.isNotEmpty ? numberController.text : null,
      );

      final response = await _authRepository.register(request);

      if (response.success) {
        userEmail = emailController.text;
        Utils.successSnackBar(
          'Success',
          response.message ?? 'Registration successful',
        );
        Get.toNamed(AppRoutes.verifyUser);
      } else {
        Utils.errorSnackBar('Error', response.message ?? 'Registration failed');
      }
    } catch (e) {
      Utils.errorSnackBar('Error', e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    start = 180; // Reset the start value
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start > 0) {
        start--;
        final minutes = (start ~/ 60).toString().padLeft(2, '0');
        final seconds = (start % 60).toString().padLeft(2, '0');

        time = "$minutes:$seconds";

        update();
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> verifyOtpRepo() async {
    if (otpController.text.isEmpty) {
      Utils.errorSnackBar('Error', 'Please enter OTP');
      return;
    }

    isLoadingVerify = true;
    update();

    try {
      final request = VerifyEmailRequestModel(
        email: userEmail.isNotEmpty ? userEmail : emailController.text,
        oneTimeCode: int.parse(otpController.text),
      );

      final response = await _authRepository.verifyEmail(request);

      if (response.success) {
        // Save user data to local storage
        LocalStorage.isLogIn = true;
        await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);

        Utils.successSnackBar(
          'Success',
          response.message ?? 'Email verified successfully',
        );
        Get.offAllNamed(AppRoutes.signIn);
      } else {
        Utils.errorSnackBar('Error', response.message ?? 'Verification failed');
      }
    } catch (e) {
      Utils.errorSnackBar('Error', e.toString());
    } finally {
      isLoadingVerify = false;
      update();
    }
  }

  Future<void> resendOtp() async {
    isLoading = true;
    update();

    try {
      final email = userEmail.isNotEmpty ? userEmail : emailController.text;
      final response = await _authRepository.resendOtp(email);

      if (response.success) {
        Utils.successSnackBar(
          'Success',
          response.message ?? 'OTP sent successfully again',
        );
      } else {
        Utils.errorSnackBar(
          'Error',
          response.message ?? 'Failed to resend OTP',
        );
      }
    } catch (e) {
      Utils.errorSnackBar('Error', e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
