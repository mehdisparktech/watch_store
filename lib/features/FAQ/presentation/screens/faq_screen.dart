import 'package:flutter/material.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/component/text_field/common_text_field.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_images.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<FAQItem> faqItems = [
    FAQItem(
      question: 'Worem ipsum dolor sit amet?',
      answer:
          'Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad...',
      isExpanded: true,
    ),
    FAQItem(
      question: 'Consectetur adipiscing elit. Nuncing?',
      answer:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      isExpanded: false,
    ),
    FAQItem(
      question: 'Nunc vulputate libero et velit in?',
      answer:
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      isExpanded: false,
    ),
    FAQItem(
      question: 'Vulputate libero et velit interdum?',
      answer:
          'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      isExpanded: false,
    ),
    FAQItem(
      question: 'Do you have an affiliate program?',
      answer:
          'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      isExpanded: false,
    ),
    FAQItem(
      question: 'Do I need to know to use this?',
      answer:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.',
      isExpanded: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'FAQ',
        profileImageUrl: AppImages.profileImage,
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.black,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonText(
                  text: 'What need help you?',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.socialIconBackground,
                  fontFamily: 'PlayfairDisplay',
                ),
                SizedBox(height: 8),
                CommonText(
                  text:
                      'Need something cleared up? Here our most frequently asked questions',
                  fontSize: 16,
                  color: AppColors.hintText,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: 16),
                CommonTextField(
                  hintText: 'Search anything',
                  prefixIcon: Icon(Icons.search, color: AppColors.white),
                  borderColor: AppColors.hintText,
                  borderRadius: 8,
                  paddingVertical: 20,
                  fillColor: AppColors.black,
                ),
                SizedBox(height: 16),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                final item = faqItems[index];
                return FAQItemWidget(
                  item: item,
                  onToggle: () {
                    setState(() {
                      item.isExpanded = !item.isExpanded;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FAQItem {
  String question;
  String answer;
  bool isExpanded;

  FAQItem({
    required this.question,
    required this.answer,
    required this.isExpanded,
  });
}

class FAQItemWidget extends StatelessWidget {
  final FAQItem item;
  final VoidCallback onToggle;

  const FAQItemWidget({super.key, required this.item, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      text: item.question,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    if (item.isExpanded)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                        child: CommonText(
                          text: item.answer,
                          fontSize: 16,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  item.isExpanded ? Icons.remove : Icons.add,
                  size: 32,
                ),
                onPressed: onToggle,
              ),
            ],
          ),
          Divider(color: AppColors.hintText),
        ],
      ),
    );
  }
}
