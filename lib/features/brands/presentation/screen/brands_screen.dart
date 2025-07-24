import 'package:flutter/material.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/features/brands/data/watch_model.dart';
import 'package:watch_store/features/brands/presentation/widgets/watch_card.dart';
import 'package:watch_store/utils/constants/app_string.dart';

class BrandsScreen extends StatelessWidget {
  BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: AppString.watchBrand),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
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
    );
  }

  final List<WatchModel> watches = [
    WatchModel(
      id: 1,
      name: 'Submariner',
      price: '\$25,000',
      imageUrl:
          "https://titanworld.com/cdn/shop/files/1802KM01_1_837a07e8-b3c1-46d3-a81c-efb2e969584d.jpg?v=1706547481",
      isFavorite: true,
    ),
    WatchModel(
      id: 2,
      name: 'Omega 11Gold',
      price: '\$25,000',
      imageUrl:
          'https://titanworld.com/cdn/shop/files/1802KM01_1_837a07e8-b3c1-46d3-a81c-efb2e969584d.jpg?v=1706547481',
      isFavorite: false,
    ),
    WatchModel(
      id: 3,
      name: 'Capiter 223A2',
      price: '\$25,000',
      imageUrl:
          'https://titanworld.com/cdn/shop/files/1802KM01_1_837a07e8-b3c1-46d3-a81c-efb2e969584d.jpg?v=1706547481',
      isFavorite: false,
    ),
    WatchModel(
      id: 4,
      name: 'Tissot - GPw',
      price: '\$25,000',
      imageUrl: 'https://example.com/tissot_gpw.jpg',
      isFavorite: true,
    ),
    WatchModel(
      id: 5,
      name: 'IWC Black Limited',
      price: '\$25,000',
      imageUrl:
          'https://titanworld.com/cdn/shop/files/1802KM01_1_837a07e8-b3c1-46d3-a81c-efb2e969584d.jpg?v=1706547481',
      isFavorite: false,
    ),
    WatchModel(
      id: 6,
      name: 'Tissot 0021',
      price: '\$25,000',
      imageUrl:
          'https://titanworld.com/cdn/shop/files/1802KM01_1_837a07e8-b3c1-46d3-a81c-efb2e969584d.jpg?v=1706547481',
      isFavorite: true,
    ),
  ];
}
