import 'package:flutter/material.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/utils/constants/app_colors.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({super.key});

  final List<NewsItem> newsItems = [
    NewsItem(
      title: 'Worem ipsum dolor sit amet, consectetur adipiscing elit.',
      image:
          'https://images.unsplash.com/photo-1586339949916-3e9457bef6d3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG5ld3N8ZW58MHx8MHx8fDA%3D',
      timeAgo: '2 hours ago',
    ),
    NewsItem(
      title: 'Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
      image:
          'https://images.unsplash.com/photo-1586339949916-3e9457bef6d3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG5ld3N8ZW58MHx8MHx8fDA%3D',
      timeAgo: '2 hours ago',
    ),
    NewsItem(
      title:
          'Consectetur adipiscing elit. Rorem ipsum dolor sit amet, adipiscing elit.',
      image:
          'https://images.unsplash.com/photo-1586339949916-3e9457bef6d3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG5ld3N8ZW58MHx8MHx8fDA%3D',
      timeAgo: '2 hours ago',
    ),
    NewsItem(
      title: 'Lpsum dolor sit amet, consectetur adipiscing elit. Rorem ipsum.',
      image:
          'https://images.unsplash.com/photo-1586339949916-3e9457bef6d3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG5ld3N8ZW58MHx8MHx8fDA%3D',
      timeAgo: '2 hours ago',
    ),
    NewsItem(
      title: 'Samet, consectetur adipiscing elit. Rorem ipsum dolor sit.',
      image:
          'https://images.unsplash.com/photo-1586339949916-3e9457bef6d3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG5ld3N8ZW58MHx8MHx8fDA%3D',
      timeAgo: '2 hours ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'News'),
      body: ListView.builder(
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          final item = newsItems[index];
          return NewsItemWidget(item: item, imageRight: index % 2 == 0);
        },
      ),
    );
  }
}

class NewsItem {
  final String title;
  final String image;
  final String timeAgo;

  NewsItem({required this.title, required this.image, required this.timeAgo});
}

class NewsItemWidget extends StatelessWidget {
  final NewsItem item;
  final bool imageRight;

  const NewsItemWidget({super.key, required this.item, this.imageRight = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                        text: item.timeAgo,
                        fontSize: 14,
                        color: AppColors.hintText,
                      ),
                      SizedBox(height: 8),
                      CommonText(
                        text: item.title,
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
                  imageSrc: item.image,
                  height: 150,
                  fill: BoxFit.cover,
                ),
              ),
          SizedBox(width: 16),
          imageRight
              ? Expanded(
                flex: 2,
                child: CommonImage(
                  imageSrc: item.image,
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
                        text: item.timeAgo,
                        fontSize: 14,
                        color: AppColors.hintText,
                      ),
                      SizedBox(height: 8),
                      CommonText(
                        text: item.title,
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
    );
  }
}
