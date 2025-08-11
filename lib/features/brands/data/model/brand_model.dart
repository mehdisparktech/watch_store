class BrandModel {
  final String? id;
  final String? name;
  final String? description;
  final String? logo;
  final String? image;
  final bool? isActive;
  final int? productCount;
  final DateTime? createdAt;

  BrandModel({
    this.id,
    this.name,
    this.description,
    this.logo,
    this.image,
    this.isActive,
    this.productCount,
    this.createdAt,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      description: json['description']?.toString(),
      logo: json['logo']?.toString(),
      image: json['image']?.toString(),
      isActive: json['is_active'],
      productCount: json['product_count']?.toInt(),
      createdAt:
          json['created_at'] != null
              ? DateTime.tryParse(json['created_at'].toString())
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'image': image,
      'is_active': isActive,
      'product_count': productCount,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  BrandModel copyWith({
    String? id,
    String? name,
    String? description,
    String? logo,
    String? image,
    bool? isActive,
    int? productCount,
    DateTime? createdAt,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
      productCount: productCount ?? this.productCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
