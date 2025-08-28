class BrandCategoryModel {
  final String id;
  final String name;
  final String? description;
  final String? image; // Full URL will be composed at UI layer if needed
  final int totalProducts;

  BrandCategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.totalProducts,
  });

  factory BrandCategoryModel.fromApi(Map<String, dynamic> json) {
    return BrandCategoryModel(
      id: (json['_id'] ?? json['id']).toString(),
      name: (json['name'] ?? '').toString(),
      description: json['description']?.toString(),
      image: json['image']?.toString(),
      totalProducts:
          int.tryParse(
            (json['totalProducts'] ?? json['total_products'] ?? 0).toString(),
          ) ??
          0,
    );
  }
}
