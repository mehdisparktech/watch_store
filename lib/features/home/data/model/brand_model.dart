class HomeBrandModel {
  final String? id;
  final String? name;
  final String? description;
  final String? image;
  final int? totalCategories;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HomeBrandModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.totalCategories,
    this.createdAt,
    this.updatedAt,
  });

  factory HomeBrandModel.fromJson(Map<String, dynamic> json) {
    return HomeBrandModel(
      id: json['_id']?.toString(),
      name: json['name']?.toString(),
      description: json['description']?.toString(),
      image: json['image']?.toString(),
      totalCategories:
          json['totalCategories'] is int
              ? json['totalCategories'] as int
              : int.tryParse(json['totalCategories']?.toString() ?? ''),
      createdAt:
          json['createdAt'] != null
              ? DateTime.tryParse(json['createdAt'].toString())
              : null,
      updatedAt:
          json['updatedAt'] != null
              ? DateTime.tryParse(json['updatedAt'].toString())
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'image': image,
      'totalCategories': totalCategories,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class HomeBrandsResponse {
  final bool success;
  final String message;
  final int statusCode;
  final HomeBrandsData data;

  HomeBrandsResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory HomeBrandsResponse.fromJson(Map<String, dynamic> json) {
    return HomeBrandsResponse(
      success: json['success'] ?? false,
      message: json['message']?.toString() ?? '',
      statusCode: json['statusCode'] ?? 0,
      data: HomeBrandsData.fromJson(
        Map<String, dynamic>.from(json['data'] ?? {}),
      ),
    );
  }
}

class HomeBrandsData {
  final HomeBrandsMeta meta;
  final List<HomeBrandModel> data;

  HomeBrandsData({required this.meta, required this.data});

  factory HomeBrandsData.fromJson(Map<String, dynamic> json) {
    return HomeBrandsData(
      meta: HomeBrandsMeta.fromJson(
        Map<String, dynamic>.from(json['meta'] ?? {}),
      ),
      data:
          (json['data'] as List?)
              ?.map(
                (e) => HomeBrandModel.fromJson(Map<String, dynamic>.from(e)),
              )
              .toList() ??
          [],
    );
  }
}

class HomeBrandsMeta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  HomeBrandsMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory HomeBrandsMeta.fromJson(Map<String, dynamic> json) {
    return HomeBrandsMeta(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}
