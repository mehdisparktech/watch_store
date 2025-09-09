import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../../config/route/app_routes.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';

class DoNotHaveAccount extends StatelessWidget {
  const DoNotHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account?".tr,
            style: AppFonts.playfairDisplayStyle(
              color: AppColors.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(text: " "),

          /// Sign Up Button here
          TextSpan(
            text: "Sign up".tr,
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    Get.offAllNamed(AppRoutes.signUp);
                  },
            style: AppFonts.playfairDisplayStyle(
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
