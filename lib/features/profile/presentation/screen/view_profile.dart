import 'package:flutter/material.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_string.dart';
import '../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../controller/profile_controller.dart';
import '../../../../../utils/constants/app_images.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,

          /// App Bar Sections Starts here
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close, color: AppColors.white),
            ),
          ),

          /// Body Sections Starts here
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// User Profile image here
                  Center(
                    child: CircleAvatar(
                      radius: 50.sp,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child:
                            LocalStorage.myImage.isNotEmpty
                                ? CommonImage(
                                  imageSrc:
                                      ApiEndPoint.imageUrl +
                                      LocalStorage.myImage,
                                  width: 100.r,
                                  height: 100.r,
                                  fill: BoxFit.cover,
                                )
                                : const CommonImage(
                                  imageSrc: AppImages.profileImage,
                                  height: 100,
                                  width: 100,
                                ),
                      ),
                    ),
                  ),
                  10.height,
                  CommonText(
                    text: LocalStorage.myName,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontFamily: 'PlayfairDisplay',
                  ),
                  10.height,
                  CommonText(
                    text: "Raconli Group",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                  60.height,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(
                      text: AppString.photos,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                  30.height,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CommonImage(
                          imageSrc: AppImages.availableWatch,
                          height: 100.r,
                          width: 100.r,
                        ),
                        20.width,
                        CommonImage(
                          imageSrc: AppImages.profileImage,
                          height: 100.r,
                          width: 100.r,
                        ),
                        20.width,
                        CommonImage(
                          imageSrc: AppImages.profileImage,
                          height: 100.r,
                          width: 100.r,
                        ),
                      ],
                    ),
                  ),
                  30.height,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(
                      text: AppString.archives,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                  30.height,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
