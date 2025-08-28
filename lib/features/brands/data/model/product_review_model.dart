class ProductReviewResponse {
  final bool success;
  final String message;
  final int statusCode;
  final ProductReviewData data;

  ProductReviewResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory ProductReviewResponse.fromJson(Map<String, dynamic> json) {
    return ProductReviewResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      data: ProductReviewData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'statusCode': statusCode,
      'data': data.toJson(),
    };
  }
}

class ProductReviewData {
  final int totalReviews;
  final List<ProductReview> reviews;

  ProductReviewData({required this.totalReviews, required this.reviews});

  factory ProductReviewData.fromJson(Map<String, dynamic> json) {
    return ProductReviewData(
      totalReviews: json['totalReviews'] ?? 0,
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((review) => ProductReview.fromJson(review))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalReviews': totalReviews,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}

class ProductReview {
  final String id;
  final ReviewUser user;
  final ReviewProduct product;
  final String comment;
  final int rating;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductReview({
    required this.id,
    required this.user,
    required this.product,
    required this.comment,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      id: json['_id'] ?? '',
      user: ReviewUser.fromJson(json['user'] ?? {}),
      product: ReviewProduct.fromJson(json['product'] ?? {}),
      comment: json['comment'] ?? '',
      rating: json['rating'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user.toJson(),
      'product': product.toJson(),
      'comment': comment,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class ReviewUser {
  final String id;
  final String name;
  final String email;
  final String profileImage;

  ReviewUser({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
    };
  }
}

class ReviewProduct {
  final String id;
  final String name;
  final double price;
  final int stock;
  final String description;
  final List<String> images;
  final String category;
  final String gender;
  final String modelNumber;
  final String movement;
  final String caseDiameter;
  final String caseThickness;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReviewProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.description,
    required this.images,
    required this.category,
    required this.gender,
    required this.modelNumber,
    required this.movement,
    required this.caseDiameter,
    required this.caseThickness,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewProduct.fromJson(Map<String, dynamic> json) {
    return ReviewProduct(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      description: json['description'] ?? '',
      images:
          (json['images'] as List<dynamic>?)
              ?.map((image) => image.toString())
              .toList() ??
          [],
      category: json['category'] ?? '',
      gender: json['gender'] ?? '',
      modelNumber: json['modelNumber'] ?? '',
      movement: json['movement'] ?? '',
      caseDiameter: json['caseDiameter'] ?? '',
      caseThickness: json['caseThickness'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'description': description,
      'images': images,
      'category': category,
      'gender': gender,
      'modelNumber': modelNumber,
      'movement': movement,
      'caseDiameter': caseDiameter,
      'caseThickness': caseThickness,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
