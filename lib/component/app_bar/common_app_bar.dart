import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/utils/constants/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.onMenuPressed,
    this.onProfilePressed,
    this.profileImageUrl,
    this.backgroundColor,
    this.titleColor,
    this.iconColor,
    this.showProfile = true,
    this.showMenu = true,
    this.elevation = 0,
    this.titleFontSize = 20,
    this.subTitle = false,
    this.titleFontWeight = FontWeight.w700,
  });

  final String title;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onProfilePressed;
  final String? profileImageUrl;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? iconColor;
  final bool showProfile;
  final bool showMenu;
  final double elevation;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final bool subTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight + 20,
      title:
          subTitle
              ? CommonText(
                text: title,
                fontSize: titleFontSize,
                fontWeight: titleFontWeight,
                color: titleColor ?? AppColors.white,
                textAlign: TextAlign.center,
                maxLines: 2,
                fontFamily: 'PlayfairDisplay',
              )
              : CommonText(
                text: title,
                fontSize: titleFontSize,
                fontWeight: titleFontWeight,
                color: titleColor ?? AppColors.white,
                textAlign: TextAlign.center,
                maxLines: 1,
                fontFamily: 'PlayfairDisplay',
              ),
      centerTitle: true,
      leading:
          showProfile
              ? Padding(
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                child: GestureDetector(
                  onTap:
                      onProfilePressed ??
                      () {
                        Get.toNamed(AppRoutes.viewProfile);
                      },
                  child: ClipOval(
                    child: CommonImage(
                      imageSrc: profileImageUrl ?? '',
                      width: 40.w,
                      height: 40.w,
                      fill: BoxFit.cover,
                    ),
                  ),
                ),
              )
              : null,
      actions:
          showMenu
              ? [
                IconButton(
                  onPressed: onMenuPressed ?? () {},
                  icon: Icon(
                    Icons.menu,
                    color: iconColor ?? AppColors.white,
                    size: 24.sp,
                  ),
                ),
              ]
              : null,
    );
  }
}
