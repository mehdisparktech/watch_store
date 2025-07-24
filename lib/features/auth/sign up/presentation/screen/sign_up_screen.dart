import 'package:flutter/material.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import '../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../controller/sign_up_controller.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../widget/already_accunt_rich_text.dart';
import '../widget/sign_up_all_filed.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section Starts Here
      appBar: AppBar(),

      /// Body Section Starts Here
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: controller.signUpFormKey,
              child: Column(
                children: [
                  /// Sign UP Instructions here
                  CommonImage(
                    imageSrc: AppImages.logo,
                    height: 50.h,
                    width: 250.w,
                  ),
                  30.height,

                  /// All Text Filed here
                  SignUpAllField(controller: controller),

                  16.height,

                  /// Submit Button Here
                  CommonButton(
                    titleText: AppString.signUp,
                    isLoading: controller.isLoading,
                    onTap: controller.signUpUser,
                  ),
                  24.height,

                  ///  Sign In Instruction here
                  const AlreadyAccountRichText(),
                  30.height,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
