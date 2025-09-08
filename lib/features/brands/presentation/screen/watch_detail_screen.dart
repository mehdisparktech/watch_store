import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/component/button/common_button.dart';
import 'package:watch_store/component/drawer/common_drawer.dart';
import 'package:watch_store/component/image/common_image.dart';
import 'package:watch_store/component/text/common_text.dart';
import 'package:watch_store/config/route/app_routes.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/features/brands/data/model/product_model.dart';
import 'package:watch_store/features/brands/presentation/controller/product_detail_controller.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import 'package:watch_store/utils/constants/app_string.dart';
import 'package:watch_store/utils/enum/enum.dart';

class WatchDetailScreen extends StatefulWidget {
  final String productId;

  const WatchDetailScreen({super.key, required this.productId});

  @override
  State<WatchDetailScreen> createState() => _WatchDetailScreenState();
}

class _WatchDetailScreenState extends State<WatchDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _imagePageController;
  int _currentImageIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _imagePageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _imagePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        title: AppString.watchDetails,
        profileImageUrl: ApiEndPoint.imageUrl + LocalStorage.myImage,
        onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: CommonDrawer(profileImage: AppImages.availableWatch),
      body: GetBuilder<ProductDetailController>(
        init: ProductDetailController(widget.productId),
        builder: (controller) {
          if (controller.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.status == Status.error || controller.product == null) {
            return const Center(child: Text('Failed to load product'));
          }
          final ProductModel product = controller.product!;
          final List<String> imageUrls =
              (product.images != null && product.images!.isNotEmpty)
                  ? product.images!
                      .map((e) => ApiEndPoint.imageUrl + e)
                      .toList()
                  : ((product.image ?? '').isNotEmpty
                      ? [ApiEndPoint.imageUrl + (product.image ?? '')]
                      : [AppImages.omega]);
          final String displayedImage = imageUrls.first;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CommonText(
                        text: product.name ?? 'Product',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayfairDisplay',
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 300,
                        child: PageView.builder(
                          controller: _imagePageController,
                          itemCount: imageUrls.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return CommonImage(
                              imageSrc: imageUrls[index],
                              height: 300,
                              width: double.infinity,
                              fill: BoxFit.contain,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      CommonText(
                        text: (product.price ?? 0).toString(),
                        fontSize: 24,
                        color: AppColors.tertiaryText,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(imageUrls.length, (index) {
                          final bool isActive = index == _currentImageIndex;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: CircleAvatar(
                              radius: 6,
                              backgroundColor:
                                  isActive
                                      ? AppColors.socialIconBackground
                                      : AppColors.tertiaryText.withValues(
                                        alpha: 0.5,
                                      ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 16),
                      if (LocalStorage.role == "USER")
                        CommonButton(
                          titleText: AppString.startChatWithRetailer,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.message,
                              arguments: true,
                              parameters: {
                                "chatId": product.createdBy ?? '',
                                "name": "", // Will be updated from API
                                "image": "", // Will be updated from API
                                "itemImage": displayedImage,
                                "itemPrice": (product.price ?? 0).toString(),
                                "itemName": product.name ?? '',
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
                      Tab(text: AppString.product),
                      Tab(text: AppString.specification),
                      Tab(text: AppString.review),
                    ],
                  ),
                ),
                // TabBarView Section
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildProductTab(product),
                      _buildSpecificationTab(product),
                      _buildReviewTab(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductTab(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: product.name ?? 'Product',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'PlayfairDisplay',
          ),
          SizedBox(height: 12),
          CommonText(
            text: product.description ?? '',
            fontSize: 14,
            color: AppColors.tertiaryText,
            fontFamily: 'PlayfairDisplay',
          ),
          SizedBox(height: 16),
          CommonText(
            text: AppString.features,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'PlayfairDisplay',
          ),
          SizedBox(height: 8),
          _buildFeatureItem(AppString.waterResistantUpTo100m),
          _buildFeatureItem(AppString.scratchResistantSapphireCrystal),
          _buildFeatureItem(AppString.swissMadeMovement),
          _buildFeatureItem(AppString.premiumLeatherStrap),
        ],
      ),
    );
  }

  Widget _buildSpecificationTab(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [_buildSpecificationTable(product)]),
    );
  }

  Widget _buildReviewTab() {
    return GetBuilder<ProductDetailController>(
      builder: (controller) {
        if (controller.reviewStatus == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.reviewStatus == Status.error ||
            controller.productReviews == null) {
          return const Center(child: Text('product no review'));
        }

        final reviews = controller.productReviews!.data.reviews;
        final totalReviews = controller.productReviews!.data.totalReviews;

        // Calculate average rating
        double averageRating = 0.0;
        if (reviews.isNotEmpty) {
          averageRating =
              reviews.map((r) => r.rating).reduce((a, b) => a + b) /
              reviews.length;
        }

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
                    text: averageRating.toStringAsFixed(1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(width: 8),
                  CommonText(
                    text: '($totalReviews reviews)',
                    fontSize: 14,
                    color: AppColors.tertiaryText,
                  ),
                ],
              ),
              SizedBox(height: 16),
              if (reviews.isEmpty)
                Center(
                  child: CommonText(
                    text: 'No reviews yet',
                    fontSize: 16,
                    color: AppColors.tertiaryText,
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: reviews.length,
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return _buildReviewItem(
                        review.user.name,
                        review.rating,
                        review.comment,
                        review.user.profileImage,
                        review.createdAt,
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpecificationTable(ProductModel product) {
    final specifications = [
      {'label': 'Gender', 'value': product.gender ?? '-'},
      {'label': 'Movement', 'value': product.movement ?? '-'},
      {'label': 'Case Thickness', 'value': product.caseThickness ?? '-'},
      {'label': 'Case Diameter', 'value': product.caseDiameter ?? '-'},
      {'label': 'Model No', 'value': product.modelNumber ?? '-'},
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

  Widget _buildReviewItem(
    String name,
    int rating,
    String comment,
    String profileImage,
    DateTime createdAt,
  ) {
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
              CircleAvatar(
                radius: 16,
                backgroundImage:
                    profileImage.isNotEmpty
                        ? NetworkImage(ApiEndPoint.imageUrl + profileImage)
                        : AssetImage(AppImages.profileImage) as ImageProvider,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: name,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonText(
                      text: _formatDate(createdAt),
                      fontSize: 12,
                      color: AppColors.tertiaryText,
                    ),
                  ],
                ),
              ),
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
          SizedBox(height: 8),
          CommonText(
            text: comment,
            fontSize: 13,
            color: AppColors.tertiaryText,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
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
