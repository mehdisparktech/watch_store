import 'package:flutter/material.dart';
import 'package:watch_store/utils/constants/app_colors.dart';

class AppTextStyle {
  static const TextStyle title = TextStyle(
    color: AppColors.tertiaryText,
    fontSize: 32,
    fontFamily: 'PlayfairDisplay',
    fontWeight: FontWeight.w700,
    height: 1.12,
  );
  static const TextStyle body = TextStyle(
    color: AppColors.hintText,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    height: 1.57,
  );
}
