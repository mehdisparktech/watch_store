// class ProductModel {
//   final String? id;
//   final String? name;
//   final String? description;
//   final double? price;
//   final double? discountPrice;
//   final String? image;
//   final List<String>? images;
//   final String? brandId;
//   final String? brandName;
//   final String? category;
//   final bool? isAvailable;
//   final int? stock;
//   final double? rating;
//   final int? reviewCount;
//   final bool? isFavorite;
//   final DateTime? createdAt;

//   ProductModel({
//     this.id,
//     this.name,
//     this.description,
//     this.price,
//     this.discountPrice,
//     this.image,
//     this.images,
//     this.brandId,
//     this.brandName,
//     this.category,
//     this.isAvailable,
//     this.stock,
//     this.rating,
//     this.reviewCount,
//     this.isFavorite,
//     this.createdAt,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id']?.toString(),
//       name: json['name']?.toString(),
//       description: json['description']?.toString(),
//       price: json['price']?.toDouble(),
//       discountPrice: json['discount_price']?.toDouble(),
//       image: json['image']?.toString(),
//       images:
//           json['images'] != null
//               ? List<String>.from(json['images'].map((x) => x.toString()))
//               : null,
//       brandId: json['brand_id']?.toString(),
//       brandName: json['brand_name']?.toString(),
//       category: json['category']?.toString(),
//       isAvailable: json['is_available'],
//       stock: json['stock']?.toInt(),
//       rating: json['rating']?.toDouble(),
//       reviewCount: json['review_count']?.toInt(),
//       isFavorite: json['is_favorite'],
//       createdAt:
//           json['created_at'] != null
//               ? DateTime.tryParse(json['created_at'].toString())
//               : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'price': price,
//       'discount_price': discountPrice,
//       'image': image,
//       'images': images,
//       'brand_id': brandId,
//       'brand_name': brandName,
//       'category': category,
//       'is_available': isAvailable,
//       'stock': stock,
//       'rating': rating,
//       'review_count': reviewCount,
//       'is_favorite': isFavorite,
//       'created_at': createdAt?.toIso8601String(),
//     };
//   }

//   ProductModel copyWith({
//     String? id,
//     String? name,
//     String? description,
//     double? price,
//     double? discountPrice,
//     String? image,
//     List<String>? images,
//     String? brandId,
//     String? brandName,
//     String? category,
//     bool? isAvailable,
//     int? stock,
//     double? rating,
//     int? reviewCount,
//     bool? isFavorite,
//     DateTime? createdAt,
//   }) {
//     return ProductModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       description: description ?? this.description,
//       price: price ?? this.price,
//       discountPrice: discountPrice ?? this.discountPrice,
//       image: image ?? this.image,
//       images: images ?? this.images,
//       brandId: brandId ?? this.brandId,
//       brandName: brandName ?? this.brandName,
//       category: category ?? this.category,
//       isAvailable: isAvailable ?? this.isAvailable,
//       stock: stock ?? this.stock,
//       rating: rating ?? this.rating,
//       reviewCount: reviewCount ?? this.reviewCount,
//       isFavorite: isFavorite ?? this.isFavorite,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }
