import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/utils/extensions/extension.dart';

class IncentivosScreen extends StatelessWidget {
  const IncentivosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF171826),
      appBar: AppBar(
        backgroundColor: Color(0xFF171826),
        title: const Text('Incentivos'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close, color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonText(
                  text: 'Programa de incentivos',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
                100.height,
                CommonImage(imageSrc: AppImages.logoSpanish),
                60.height,
                CommonImage(imageSrc: AppImages.incentivos),
                40.height,
                CommonText(
                  text:
                      'El pago de los incentivos generados en el mes se realizará a más tardar 1 mes posterior a la fecha en que se notifiquen oficialmente las ventas correspondientes a Raconli Group.',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
