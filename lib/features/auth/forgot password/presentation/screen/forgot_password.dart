import 'package:flutter/material.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../../../../../../utils/helpers/other_helper.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder:
          (controller) => Scaffold(
            /// App Bar Section
            appBar: AppBar(
              title: CommonText(
                text: AppString.forgotPassword,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),

            /// body section
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.h),
                    CommonImage(imageSrc: AppImages.logo, width: 300.w),
                    SizedBox(height: 20.h),

                    /// instruction how to get OTP
                    Center(
                      child: CommonText(
                        text: AppString.forgotPasswords,
                        fontSize: 18,
                        top: 20.h,
                        bottom: 60,
                        maxLines: 3,
                      ),
                    ),

                    /// forget password take email for reset Password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CommonText(text: AppString.email),
                    ),
                    SizedBox(height: 20.h),
                    CommonTextField(
                      controller: controller.emailController,
                      //prefixIcon: const Icon(Icons.mail),
                      hintText: AppString.email,
                      validator: OtherHelper.emailValidator,
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),

                      /// Submit Button
                      child: CommonButton(
                        titleText: AppString.continues,
                        isLoading: controller.isLoadingEmail,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            controller.forgotPasswordRepo();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Bottom Navigation Bar Section
            // bottomNavigationBar: Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),

            //   /// Submit Button
            //   child: CommonButton(
            //     titleText: AppString.continues,
            //     isLoading: controller.isLoadingEmail,
            //     onTap: () {
            //       if (formKey.currentState!.validate()) {
            //         controller.forgotPasswordRepo();
            //       }
            //     },
            //   ),
            // ),
          ),
    );
  }
}
