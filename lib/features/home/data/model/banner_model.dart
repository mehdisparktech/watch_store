class BannerModel {
  final String? id;
  final String? title;
  final String? description;
  final String? image;
  final String? actionType; // 'product', 'category', 'brand', 'url'
  final String? actionValue;
  final bool? isActive;
  final int? order;
  final DateTime? createdAt;

  BannerModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.actionType,
    this.actionValue,
    this.isActive,
    this.order,
    this.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id']?.toString(),
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      image: json['image']?.toString(),
      actionType: json['action_type']?.toString(),
      actionValue: json['action_value']?.toString(),
      isActive: json['is_active'],
      order: json['order']?.toInt(),
      createdAt:
          json['created_at'] != null
              ? DateTime.tryParse(json['created_at'].toString())
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'action_type': actionType,
      'action_value': actionValue,
      'is_active': isActive,
      'order': order,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
