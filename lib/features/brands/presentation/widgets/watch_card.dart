import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/features/brands/data/watch_model.dart';

class WatchCard extends StatelessWidget {
  final WatchModel watch;

  const WatchCard({super.key, required this.watch});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.watchDetail, arguments: watch);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(
                    watch.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white.withValues(alpha: 0.8),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: watch.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          watch.isFavorite = !watch.isFavorite;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    watch.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    watch.price,
                    style: TextStyle(fontSize: 16, color: Colors.orange),
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
