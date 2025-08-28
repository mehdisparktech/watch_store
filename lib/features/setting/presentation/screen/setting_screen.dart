import 'package:flutter/material.dart';
import 'package:watch_store/component/button/common_button.dart';
import 'package:watch_store/component/text_field/common_text_field.dart';
import '../../../../../utils/helpers/other_helper.dart';
import '../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/text/common_text.dart';
import '../controller/setting_controller.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_string.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      /// App Bar Section starts here
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close, color: AppColors.white),
        ),
      ),

      /// Body Section starts here
      body: GetBuilder<SettingController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText(
                    text: AppString.configuration,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                  40.height,

                  /// User Email here
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(
                      text: AppString.registerEmail,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      bottom: 12,
                      color: AppColors.white,
                    ),
                  ),
                  CommonTextField(
                    controller: controller.emailController,
                    validator: OtherHelper.validator,
                    hintText: AppString.email,
                    keyboardType: TextInputType.emailAddress,
                    borderColor: AppColors.white,
                    fillColor: AppColors.transparent,
                    textColor: AppColors.white,
                  ),
                  60.height,
                  CommonButton(
                    titleText: AppString.changeEmail,
                    isLoading: controller.isLoading,
                    onTap: controller.editProfileRepo,
                    buttonColor: AppColors.socialIconBackground,
                    titleColor: AppColors.buttonText,
                    buttonWidth: 180.w,
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
