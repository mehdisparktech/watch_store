import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/drawer/common_drawer.dart';
import 'package:watch_store/component/text_field/common_text_field.dart';
import 'package:watch_store/features/brands/data/watch_model.dart';
import 'package:watch_store/features/wishlist/presentation/widgets/watch_card.dart';
import 'package:watch_store/utils/constants/app_icons.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/component/image/common_image.dart';

class WishlistScreen extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  WishlistScreen({super.key, this.title = 'Brands'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        title: 'Wishlist',
        subTitle: true,
        profileImageUrl: AppImages.profileImage,
        onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: CommonDrawer(profileImage: AppImages.availableWatch),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: CommonTextField(
                hintText: 'Search...',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: CommonImage(imageSrc: AppIcons.search, size: 24),
                ),
                paddingVertical: 16,
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: watches.length,
                itemBuilder: (context, index) {
                  return WatchCard(watch: watches[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<WatchModel> watches = [
    WatchModel(
      id: 1,
      name: 'Submariner',
      price: '\$25,000',
      imageUrl: AppImages.submariner,
      isFavorite: true,
    ),

    WatchModel(
      id: 4,
      name: 'Tissot - GPw',
      price: '\$25,000',
      imageUrl: AppImages.tissotGpw,
      isFavorite: true,
    ),

    WatchModel(
      id: 6,
      name: 'Tissot 0021',
      price: '\$25,000',
      imageUrl: AppImages.tissotGpw,
      isFavorite: true,
    ),
  ];
}
