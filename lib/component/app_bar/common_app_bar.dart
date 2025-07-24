import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/component/text/common_text.dart';
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: backgroundColor ?? AppColors.black,
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight + 20,
      title: CommonText(
        text: title,
        fontSize: titleFontSize,
        fontWeight: titleFontWeight,
        color: titleColor ?? AppColors.white,
      ),
      centerTitle: true,
      leading:
          showProfile
              ? Padding(
                padding: EdgeInsets.all(8.w),
                child: GestureDetector(
                  onTap: onProfilePressed,
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage:
                        profileImageUrl != null
                            ? Image.asset(profileImageUrl!).image
                            : null,
                    child:
                        profileImageUrl == null
                            ? Icon(
                              Icons.person,
                              color: iconColor ?? AppColors.white,
                              size: 24.sp,
                            )
                            : null,
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
