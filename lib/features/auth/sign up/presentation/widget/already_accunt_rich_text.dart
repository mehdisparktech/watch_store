import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_store/utils/constants/app_string.dart';

import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';

class AlreadyAccountRichText extends StatelessWidget {
  const AlreadyAccountRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          /// Already Have Account
          TextSpan(
            text: AppString.alreadyHaveAccount,
            style: AppFonts.playfairDisplayStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          /// Sign In Button Here
          TextSpan(
            text: " ${AppString.signIn}",
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    Get.offAllNamed(AppRoutes.signIn);
                  },
            style: AppFonts.playfairDisplayStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
