import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/features/brands/data/model/product_model.dart';
import 'package:watch_store/utils/constants/app_images.dart';

class WatchCard extends StatelessWidget {
  final ProductModel watch;
  final VoidCallback onPressed;

  const WatchCard({super.key, required this.watch, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final id = watch.id ?? '';
        Get.toNamed(AppRoutes.watchDetail, arguments: id);
      },
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonText(
                      text: watch.name ?? '',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlayfairDisplay',
                    ),
                    CommonText(
                      text: watch.price.toString(),
                      fontSize: 16,
                      color: Colors.orange.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 60,
            child: SizedBox(
              height: 150,
              width: 150,
              child: CommonImage(
                imageSrc:
                    (watch.images != null &&
                            watch.images!.isNotEmpty &&
                            watch.images!.first.isNotEmpty)
                        ? ApiEndPoint.imageUrl + watch.images!.first
                        : ((watch.image ?? '').isNotEmpty
                            ? ApiEndPoint.imageUrl + (watch.image ?? '')
                            : AppImages.omega),
                fill: BoxFit.contain,
              ),
            ),
          ),
          // Favorite button positioned outside the image area
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.favorite, color: Colors.red, size: 20),
                padding: EdgeInsets.zero,
                onPressed: onPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
