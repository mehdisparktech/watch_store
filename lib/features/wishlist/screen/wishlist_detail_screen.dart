import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/button/common_button.dart';
import 'package:watch_store/component/drawer/common_drawer.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/features/brands/data/watch_model.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_images.dart';

class WishlistDetailScreen extends StatefulWidget {
  final WatchModel watch;

  const WishlistDetailScreen({super.key, required this.watch});

  @override
  State<WishlistDetailScreen> createState() => _WishlistDetailScreenState();
}

class _WishlistDetailScreenState extends State<WishlistDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        title: 'Watch Detail',
        profileImageUrl: AppImages.profileImage,
        onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: CommonDrawer(profileImage: AppImages.availableWatch),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CommonText(
                    text: 'Rolex ${widget.watch.name}',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                  SizedBox(height: 16),
                  Image.asset(
                    widget.watch.imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 16),
                  CommonText(
                    text: widget.watch.price,
                    fontSize: 24,
                    color: AppColors.tertiaryText,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: AppColors.socialIconBackground,
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: AppColors.tertiaryText.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: AppColors.tertiaryText.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: AppColors.tertiaryText.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  CommonButton(
                    titleText: 'Start Chat With Retailer',
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.message,
                        arguments: true,
                        parameters: {
                          "chatId": "123",
                          "name": widget.watch.name,
                          "image": AppImages.profileImage,
                          "itemImage": widget.watch.imageUrl,
                          "itemPrice": widget.watch.price,
                          "itemName": widget.watch.name,
                        },
                      );
                    },
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
            // TabBar Section
            Container(
              color: AppColors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.primaryText,
                unselectedLabelColor: AppColors.hintText,
                indicatorColor: AppColors.socialIconBackground,
                indicatorWeight: 2,
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'PlayfairDisplay',
                ),
                tabs: [
                  Tab(text: 'Product'),
                  Tab(text: 'Specification'),
                  Tab(text: 'Review'),
                ],
              ),
            ),
            // TabBarView Section
            SizedBox(
              height: 400,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildProductTab(),
                  _buildSpecificationTab(),
                  _buildReviewTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: 'Rolex ${widget.watch.name}',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'PlayfairDisplay',
          ),
          SizedBox(height: 12),
          CommonText(
            text:
                'This is a premium luxury watch from Rolex featuring exceptional craftsmanship and timeless design. Perfect for both formal and casual occasions.',
            fontSize: 14,
            color: AppColors.tertiaryText,
            fontFamily: 'PlayfairDisplay',
          ),
          SizedBox(height: 16),
          CommonText(
            text: 'Features:',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'PlayfairDisplay',
          ),
          SizedBox(height: 8),
          _buildFeatureItem('• Water resistant up to 100m'),
          _buildFeatureItem('• Scratch-resistant sapphire crystal'),
          _buildFeatureItem('• Swiss made movement'),
          _buildFeatureItem('• Premium leather strap'),
        ],
      ),
    );
  }

  Widget _buildSpecificationTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [_buildSpecificationTable()]),
    );
  }

  Widget _buildReviewTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 4),
              CommonText(
                text: '4.8',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 8),
              CommonText(
                text: '(124 reviews)',
                fontSize: 14,
                color: AppColors.tertiaryText,
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildReviewItem(
            'John Doe',
            5,
            'Excellent quality watch! Highly recommended.',
          ),
          SizedBox(height: 12),
          _buildReviewItem(
            'Jane Smith',
            4,
            'Beautiful design and great build quality.',
          ),
          SizedBox(height: 12),
          _buildReviewItem(
            'Mike Johnson',
            5,
            'Perfect watch for daily wear. Love it!',
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificationTable() {
    final specifications = [
      {'label': 'Gender', 'value': 'Male'},
      {'label': 'Movement', 'value': 'Quartz Battery'},
      {'label': 'Case Thickness', 'value': '12 mm'},
      {'label': 'Case Diameter', 'value': '44 mm'},
      {'label': 'Model No', 'value': 'NK1789'},
      {'label': 'Water Resistance', 'value': '100m'},
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children:
            specifications.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> spec = entry.value;
              bool isEven = index % 2 == 0;

              return Container(
                decoration: BoxDecoration(
                  color: isEven ? Colors.grey.shade100 : Colors.white,
                  border:
                      index < specifications.length - 1
                          ? Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          )
                          : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonText(
                          text: spec['label']!,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CommonText(
                          text: spec['value']!,
                          fontSize: 16,
                          color: AppColors.tertiaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: CommonText(
        text: feature,
        fontSize: 14,
        color: AppColors.tertiaryText,
      ),
    );
  }

  Widget _buildReviewItem(String name, int rating, String comment) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonText(text: name, fontSize: 14, fontWeight: FontWeight.bold),
              Spacer(),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    size: 16,
                    color: index < rating ? Colors.amber : Colors.grey.shade300,
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 4),
          CommonText(
            text: comment,
            fontSize: 13,
            color: AppColors.tertiaryText,
          ),
        ],
      ),
    );
  }
}
