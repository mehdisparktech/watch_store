import 'package:flutter/material.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/text_field/common_text_field.dart';
import 'package:watch_store/features/brands/data/watch_model.dart';
import 'package:watch_store/features/brands/presentation/widgets/watch_card.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/utils/constants/app_string.dart';

class BrandsScreen extends StatelessWidget {
  final String title;
  BrandsScreen({super.key, this.title = 'Brands'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: '$title \n 150 ${AppString.watchBrand}',
        subTitle: true,
        profileImageUrl: AppImages.profileImage,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: CommonTextField(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
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
      id: 2,
      name: 'Omega 11Gold',
      price: '\$25,000',
      imageUrl: AppImages.tissotGpw,
      isFavorite: false,
    ),
    WatchModel(
      id: 3,
      name: 'Capiter 223A2',
      price: '\$25,000',
      imageUrl: AppImages.iwc,
      isFavorite: false,
    ),
    WatchModel(
      id: 4,
      name: 'Tissot - GPw',
      price: '\$25,000',
      imageUrl: AppImages.tissotGpw,
      isFavorite: true,
    ),
    WatchModel(
      id: 5,
      name: 'IWC Black Limited',
      price: '\$25,000',
      imageUrl: AppImages.tissotGpw,
      isFavorite: false,
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
