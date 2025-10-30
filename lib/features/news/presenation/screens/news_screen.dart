import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/drawer/common_drawer.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/utils/constants/app_string.dart';
import 'package:watch_store/utils/enum/enum.dart';
import 'package:watch_store/config/route/app_routes.dart';
import '../controller/news_controller.dart';
import '../../data/model/news_model.dart';

class NewsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        title: AppString.news,
        profileImageUrl: ApiEndPoint.imageUrl + LocalStorage.myImage,
        onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: CommonDrawer(profileImage: AppImages.availableWatch),
      body: GetBuilder<NewsController>(
        builder: (controller) {
          if (controller.status == Status.loading &&
              controller.newsList.isEmpty) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (controller.status == Status.error &&
              controller.newsList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText(text: AppString.someThingWrong),
                  ElevatedButton(
                    onPressed: () => controller.getNews(refresh: true),
                    child: CommonText(text: AppString.tryAgain),
                  ),
                ],
              ),
            );
          } else if (controller.newsList.isEmpty) {
            return Center(child: CommonText(text: AppString.dataEmpty));
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                controller.loadMore();
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () => controller.getNews(refresh: true),
              child: ListView.builder(
                itemCount:
                    controller.newsList.length +
                    (controller.hasMoreData ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.newsList.length) {
                    return controller.isLoading
                        ? const Center(child: CupertinoActivityIndicator())
                        : const SizedBox();
                  }

                  final item = controller.newsList[index];
                  return NewsItemWidget(item: item, imageRight: index % 2 == 0);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class NewsItemWidget extends StatelessWidget {
  final NewsModel item;
  final bool imageRight;

  const NewsItemWidget({super.key, required this.item, this.imageRight = true});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        item.image != null && item.image!.isNotEmpty
            ? "${ApiEndPoint.imageUrl}${item.image}"
            : "https://images.unsplash.com/photo-1586339949916-3e9457bef6d3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG5ld3N8ZW58MHx8MHx8fDA%3D";

    final String timeAgo =
        item.createdAt != null ? _getTimeAgo(item.createdAt!) : '2 hours ago';

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.newsDetails, arguments: item),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(color: AppColors.textFieldBackground),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            imageRight
                ? Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonText(
                          text: timeAgo,
                          fontSize: 14,
                          color: AppColors.hintText,
                        ),
                        const SizedBox(height: 8),
                        CommonText(
                          text: item.title ?? '',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                )
                : Expanded(
                  flex: 2,
                  child: CommonImage(
                    imageSrc: imageUrl,
                    height: 150,
                    fill: BoxFit.cover,
                  ),
                ),
            const SizedBox(width: 16),
            imageRight
                ? Expanded(
                  flex: 2,
                  child: CommonImage(
                    imageSrc: imageUrl,
                    height: 150,
                    fill: BoxFit.cover,
                  ),
                )
                : Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonText(
                          text: timeAgo,
                          fontSize: 14,
                          color: AppColors.hintText,
                        ),
                        const SizedBox(height: 8),
                        CommonText(
                          text: item.title ?? '',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
