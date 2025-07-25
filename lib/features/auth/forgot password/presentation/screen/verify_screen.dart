import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../utils/constants/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../../utils/constants/app_string.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final formKey = GlobalKey<FormState>();

  /// init State here
  @override
  void initState() {
    ForgetPasswordController.instance.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section
      appBar: AppBar(
        title: const CommonText(
          text: AppString.forgotPassword,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),

      /// Body Section
      body: GetBuilder<ForgetPasswordController>(
        builder:
            (controller) => SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 100.h),
                    CommonImage(imageSrc: AppImages.logo, width: 300.w),
                    SizedBox(height: 20.h),

                    /// instruction how to get OTP
                    Center(
                      child: CommonText(
                        text: AppString.otpVerifyInstruction,
                        fontSize: 18,
                        top: 20.h,
                        bottom: 60,
                      ),
                    ),

                    /// OTP Filed here
                    Flexible(
                      flex: 0,
                      child: PinCodeTextField(
                        controller: controller.otpController,
                        validator: (value) {
                          if (value != null && value.length == 6) {
                            return null;
                          } else {
                            return AppString.otpIsInValid;
                          }
                        },
                        autoDisposeControllers: false,
                        cursorColor: AppColors.black,
                        appContext: (context),
                        autoFocus: true,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 60.h,
                          fieldWidth: 60.w,
                          activeFillColor: AppColors.transparent,
                          selectedFillColor: AppColors.transparent,
                          inactiveFillColor: AppColors.transparent,
                          borderWidth: 0.5.w,
                          selectedColor: AppColors.primaryColor,
                          activeColor: AppColors.primaryColor,
                          inactiveColor: AppColors.black,
                        ),
                        length: 4,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.disabled,
                        enableActiveFill: true,
                      ),
                    ),

                    /// Resent OTP or show Timer
                    GestureDetector(
                      onTap:
                          controller.time == '00:00'
                              ? () {
                                controller.startTimer();
                                controller.forgotPasswordRepo();
                              }
                              : () {},
                      child: CommonText(
                        text:
                            controller.time == '00:00'
                                ? AppString.resendCode
                                : "${AppString.resendCodeIn} ${controller.time} ${AppString.minute}",
                        top: 60,
                        bottom: 100,
                        fontSize: 18,
                      ),
                    ),

                    ///  Submit Button here
                    CommonButton(
                      titleText: AppString.verify,
                      isLoading: controller.isLoadingVerify,
                      onTap: () {
                        // if (formKey.currentState!.validate()) {
                        //   controller.verifyOtpRepo();
                        // }
                        Get.offNamed(AppRoutes.createPassword);
                      },
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
