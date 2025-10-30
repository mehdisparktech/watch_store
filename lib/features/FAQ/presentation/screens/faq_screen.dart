import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/drawer/common_drawer.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/utils/constants/app_string.dart';
import '../controller/faq_controller.dart';
import '../../../../utils/enum/enum.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        title: AppString.faq,
        profileImageUrl: ApiEndPoint.imageUrl + LocalStorage.myImage,
        onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: CommonDrawer(profileImage: AppImages.availableWatch),
      body: Column(
        children: [
          Container(
            color: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonText(
                  text: AppString.whatNeedHelpYou,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.socialIconBackground,
                  fontFamily: 'PlayfairDisplay',
                ),
                SizedBox(height: 8),
                CommonText(
                  text: AppString.needSomethingClearedUp,
                  fontSize: 16,
                  color: AppColors.hintText,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: 16),
                // CommonTextField(
                //   hintText: 'Search anything',
                //   prefixIcon: Icon(Icons.search, color: AppColors.white),
                //   borderColor: AppColors.hintText,
                //   borderRadius: 8,
                //   paddingVertical: 20,
                //   fillColor: AppColors.primaryColor,
                // ),
                // SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<FAQController>(
              builder: (controller) {
                if (controller.status == Status.loading) {
                  return Center(child: CupertinoActivityIndicator());
                } else if (controller.status == Status.error) {
                  return Center(child: Text('Failed to load FAQs'));
                } else if (controller.faqList.isEmpty) {
                  return Center(child: Text('No FAQs available'));
                }

                return ListView.builder(
                  itemCount: controller.faqList.length,
                  itemBuilder: (context, index) {
                    final item = controller.faqList[index];
                    return FAQItemWidget(
                      question: item.question ?? '',
                      answer: item.answer ?? '',
                      onToggle: () {},
                    );
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

class FAQItemWidget extends StatefulWidget {
  final String question;
  final String answer;
  final VoidCallback onToggle;

  const FAQItemWidget({
    super.key,
    required this.question,
    required this.answer,
    required this.onToggle,
  });

  @override
  State<FAQItemWidget> createState() => _FAQItemWidgetState();
}

class _FAQItemWidgetState extends State<FAQItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      text: widget.question,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                        child: CommonText(
                          text: widget.answer,
                          fontSize: 16,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(isExpanded ? Icons.remove : Icons.add, size: 32),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                  widget.onToggle();
                },
              ),
            ],
          ),
          Divider(color: AppColors.hintText),
        ],
      ),
    );
  }
}
