class NewsModel {
  final String? id;
  final String? title;
  final String? description;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NewsModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['_id']?.toString(),
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      image: json['image']?.toString(),
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
      'title': title,
      'description': description,
      'image': image,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class NewsResponse {
  final bool success;
  final String message;
  final int statusCode;
  final NewsData data;

  NewsResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      data: NewsData.fromJson(json['data'] ?? {}),
    );
  }
}

class NewsData {
  final NewsMeta meta;
  final List<NewsModel> data;

  NewsData({required this.meta, required this.data});

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      meta: NewsMeta.fromJson(json['meta'] ?? {}),
      data:
          (json['data'] as List?)?.map((e) => NewsModel.fromJson(e)).toList() ??
          [],
    );
  }
}

class NewsMeta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  NewsMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory NewsMeta.fromJson(Map<String, dynamic> json) {
    return NewsMeta(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}
