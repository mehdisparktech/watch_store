import 'package:flutter/material.dart';
import 'package:watch_store/utils/extensions/extension.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';
import '../controller/profile_controller.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../../../../utils/helpers/other_helper.dart';

class EditProfileAllFiled extends StatelessWidget {
  const EditProfileAllFiled({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// User Full Name here
        CommonText(
          text: AppString.fullName,
          fontWeight: FontWeight.w500,
          bottom: 12,
          color: AppColors.white,
        ),
        CommonTextField(
          controller: controller.nameController,
          validator: OtherHelper.validator,
          hintText: AppString.fullName,
          keyboardType: TextInputType.text,
          borderColor: AppColors.secondary,
          fillColor: AppColors.transparent,
          textColor: AppColors.white,
        ),
        30.height,

        /// User Email here
        CommonText(
          text: AppString.enterprise,
          fontWeight: FontWeight.w500,
          bottom: 12,
          color: AppColors.white,
        ),
        CommonTextField(
          controller: controller.enterprise,
          validator: OtherHelper.validator,
          hintText: AppString.enterprise,
          keyboardType: TextInputType.emailAddress,
          borderColor: AppColors.secondary,
          fillColor: AppColors.transparent,
          textColor: AppColors.white,
        ),

        /// User Phone number here
        // const CommonText(
        //   text: AppString.contact,
        //   fontWeight: FontWeight.w600,
        //   top: 20,
        //   bottom: 12,
        // ),
        // CommonPhoneNumberTextFiled(
        //   controller: controller.numberController,
        //   countryChange: (value) {
        //     appLog(value);
        //   },
        // ),
      ],
    );
  }
}
