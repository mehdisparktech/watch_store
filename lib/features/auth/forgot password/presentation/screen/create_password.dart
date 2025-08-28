import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/extensions/extension.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../../../../../../utils/helpers/other_helper.dart';

class CreatePassword extends StatelessWidget {
  CreatePassword({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section starts here
      appBar: AppBar(
        title: CommonText(
          text: AppString.createNewPassword,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),

      /// Body Section starts here
      body: GetBuilder<ForgetPasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  64.height,

                  /// Reset password image here
                  Center(
                    child: CommonImage(imageSrc: AppImages.logo, width: 300.w),
                  ),

                  /// Instruction of Creating New Password
                  Center(
                    child: CommonText(
                      text: AppString.createYourNewPassword,
                      fontSize: 18,
                      textAlign: TextAlign.start,
                      top: 64,
                      bottom: 24,
                    ),
                  ),

                  /// New Password here
                  20.height,
                  SizedBox(height: 20.h),
                  CommonTextField(
                    controller: controller.passwordController,
                    //prefixIcon: const Icon(Icons.lock),
                    hintText: AppString.password,
                    isPassword: true,
                    validator: OtherHelper.passwordValidator,
                  ),

                  /// Confirm Password here
                  20.height,
                  CommonTextField(
                    controller: controller.confirmPasswordController,
                    //prefixIcon: const Icon(Icons.lock),
                    hintText: AppString.confirmPassword,
                    validator:
                        (value) => OtherHelper.confirmPasswordValidator(
                          value,
                          controller.passwordController,
                        ),
                    isPassword: true,
                  ),
                  64.height,

                  /// Submit Button here
                  CommonButton(
                    titleText: AppString.continues,
                    isLoading: controller.isLoadingReset,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.resetPasswordRepo();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
