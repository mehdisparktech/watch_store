import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import '../../data/model/news_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsModel newsItem;

  const NewsDetailsScreen({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        newsItem.image != null && newsItem.image!.isNotEmpty
            ? "${ApiEndPoint.imageUrl}${newsItem.image}"
            : "https://images.unsplash.com/photo-1586339949916-3e9457bef6d3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG5ld3N8ZW58MHx8MHx8fDA%3D";

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Image with Back Button and Title Overlay
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            backgroundColor: AppColors.black,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.white,
              ),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CommonImage(
                    imageSrc: imageUrl,
                    fill: BoxFit.cover,
                    width: double.infinity,
                  ),
                  // Dark overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                  // Title overlay
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: CommonText(
                      text:
                          newsItem.title ??
                          'Rorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  CommonText(
                    text: newsItem.description ?? _getDefaultDescription(),
                    fontSize: 16,
                    color: AppColors.black,
                    maxLines: 10,
                  ),

                  const SizedBox(height: 30),

                  // Additional Images Grid
                  _buildImageGrid(),

                  const SizedBox(height: 30),

                  // Second Title Section
                  CommonText(
                    text: "Sit amet, consectetur adipiscing",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),

                  const SizedBox(height: 15),

                  // Additional Description
                  CommonText(
                    text: _getAdditionalDescription(),
                    fontSize: 16,
                    color: AppColors.black,
                  ),

                  const SizedBox(height: 30),

                  // Tags
                  _buildTags(),

                  const SizedBox(height: 20),

                  // Final Description
                  CommonText(
                    text: _getAdditionalDescription(),
                    fontSize: 16,
                    color: AppColors.black,
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    return Row(
      children: [
        Expanded(
          child: CommonImage(
            imageSrc:
                "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&auto=format&fit=crop&q=60",
            height: 200,
            fill: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CommonImage(
            imageSrc:
                "https://images.unsplash.com/photo-1594534475808-b18fc33b045e?w=500&auto=format&fit=crop&q=60",
            height: 200,
            fill: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildTags() {
    final tags = ['#watch', '#luxury', '#Gold'];

    return Wrap(
      spacing: 10,
      children:
          tags
              .map(
                (tag) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CommonText(
                    text: tag,
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ),
              )
              .toList(),
    );
  }

  String _getDefaultDescription() {
    return "The third-person role play game (RPG) focuses on a Han Solo-inspired scoundrel, Kay Vass, and is set between the events of the 1980 hit The Empire Strikes Back and 1983's Return Of The Jedi.\n\nThe game encourages fighting, stealing, and even gambling despite being set in a franchise widely perceived as being child-friendly.";
  }

  String _getAdditionalDescription() {
    return "The third-person role play game (RPG) focuses on a Han Solo-inspired scoundrel, Kay Vass, and is set between the events of the 1980 hit The Empire Strikes Back and 1983's Return Of The Jedi.\n\nThe game encourages fighting, stealing, and even gambling despite being set in a franchise widely perceived as being child-friendly.";
  }
}
