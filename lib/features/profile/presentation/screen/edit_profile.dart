import 'package:flutter/material.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_string.dart';
import '../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../controller/profile_controller.dart';
import '../../../../../utils/constants/app_images.dart';
import '../widgets/edit_profile_all_filed.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

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
                  Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 40.sp,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child:
                                LocalStorage.myImage.isNotEmpty
                                    ? CommonImage(
                                      imageSrc:
                                          ApiEndPoint.imageUrl +
                                          LocalStorage.myImage,
                                      width: 80.r,
                                      height: 80.r,
                                      fill: BoxFit.cover,
                                    )
                                    : const CommonImage(
                                      imageSrc: AppImages.profile,
                                      height: 80,
                                      width: 80,
                                    ),
                          ),
                        ),
                      ),

                      /// image change icon here
                      Positioned(
                        bottom: 0,
                        left: Get.width * 0.50,
                        child: GestureDetector(
                          onTap: controller.getProfileImage,
                          child: Container(
                            padding: EdgeInsets.all(4.sp),
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                    text: LocalStorage.enterprise,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                  60.height,

                  /// user all information filed here
                  EditProfileAllFiled(controller: controller),
                  60.height,

                  /// Submit Button here
                  CommonButton(
                    titleText: AppString.save,
                    isLoading: controller.isLoading,
                    onTap: controller.editProfileRepo,
                    buttonColor: AppColors.socialIconBackground,
                    titleColor: AppColors.buttonText,
                    buttonWidth: 160.w,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
