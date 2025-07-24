import 'package:flutter/material.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/button/common_button.dart';
import 'package:watch_store/features/brands/data/watch_model.dart';
import 'package:watch_store/utils/constants/app_images.dart';

class WatchDetailScreen extends StatelessWidget {
  final WatchModel watch;

  const WatchDetailScreen({super.key, required this.watch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Watch Detail',
        profileImageUrl: AppImages.profileImage,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Rolex ${watch.name}',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Image.asset(
                    watch.imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 16),
                  Text(
                    watch.price,
                    style: TextStyle(fontSize: 24, color: Colors.orange),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(radius: 8, backgroundColor: Colors.orange),
                      SizedBox(width: 8),
                      CircleAvatar(radius: 8, backgroundColor: Colors.grey),
                      SizedBox(width: 8),
                      CircleAvatar(radius: 8, backgroundColor: Colors.grey),
                      SizedBox(width: 8),
                      CircleAvatar(radius: 8, backgroundColor: Colors.grey),
                    ],
                  ),
                  SizedBox(height: 16),
                  CommonButton(titleText: 'Start Chat With Retailer'),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Product'),
                      Text('Specification'),
                      Text('Review'),
                    ],
                  ),
                  SizedBox(height: 16),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Gender')),
                      DataColumn(label: Text('Male')),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(Text('Model No')),
                          DataCell(Text('NK1789')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Movement')),
                          DataCell(Text('Quartz Battery')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Case Diameter')),
                          DataCell(Text('44 mm')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Case Thickness')),
                          DataCell(Text('12 mm')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
