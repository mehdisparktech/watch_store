import 'package:flutter/material.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import '../../../../../../config/route/app_routes.dart';
import '../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/sign_in_controller.dart';

import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../../../../../../utils/helpers/other_helper.dart';
import '../widgets/do_not_account.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Sections Starts here
      appBar: AppBar(),

      /// Body Sections Starts here
      body: GetBuilder<SignInController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Log In Instruction here
                  CommonImage(
                    imageSrc: AppImages.logo,
                    height: 50.h,
                    width: 250.w,
                  ),
                  30.height,

                  /// Account Email Input here
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(
                      text: AppString.email,
                      bottom: 10,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CommonTextField(
                    controller: controller.emailController,

                    hintText: AppString.email,
                    validator: OtherHelper.emailValidator,
                  ),
                  20.height,

                  /// Account Password Input here
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(
                      text: AppString.password,
                      bottom: 10,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CommonTextField(
                    controller: controller.passwordController,
                    isPassword: true,
                    hintText: AppString.password,
                    validator: OtherHelper.passwordValidator,
                  ),

                  /// Forget Password Button here
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                      child: CommonText(
                        text: AppString.forgotThePassword,
                        top: 15,
                        bottom: 20,
                        color: AppColors.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  /// Submit Button here
                  CommonButton(
                    titleText: AppString.logIn,
                    isLoading: controller.isLoading,
                    onTap: controller.signInUser,
                  ),

                  20.height,

                  /// Social Icon Buttons here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIconButton(Icons.facebook, () {}),
                      10.width,
                      _buildSocialIconButton(Icons.apple, () {}),
                    ],
                  ),
                  30.height,

                  /// Account Creating Instruction here
                  const DoNotHaveAccount(),
                  30.height,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSocialIconButton(IconData icon, VoidCallback onTap) {
    return Container(
      width: 45.w,
      height: 45.h,

      decoration: BoxDecoration(
        color: AppColors.socialIconBackground,
        borderRadius: BorderRadius.circular(100),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Center(child: Icon(icon, size: 24, color: AppColors.white)),
      ),
    );
  }
}
