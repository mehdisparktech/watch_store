// class WishlistItemModel {
//   final String? id;
//   final String? userId;
//   final String? productId;
//   final ProductModel? product;
//   final DateTime? createdAt;

//   WishlistItemModel({
//     this.id,
//     this.userId,
//     this.productId,
//     this.product,
//     this.createdAt,
//   });

//   factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
//     return WishlistItemModel(
//       id: json['id']?.toString(),
//       userId: json['user_id']?.toString(),
//       productId: json['product_id']?.toString(),
//       product:
//           json['product'] != null
//               ? ProductModel.fromJson(json['product'])
//               : null,
//       createdAt:
//           json['created_at'] != null
//               ? DateTime.tryParse(json['created_at'].toString())
//               : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'product_id': productId,
//       'product': product?.toJson(),
//       'created_at': createdAt?.toIso8601String(),
//     };
//   }

//   WishlistItemModel copyWith({
//     String? id,
//     String? userId,
//     String? productId,
//     ProductModel? product,
//     DateTime? createdAt,
//   }) {
//     return WishlistItemModel(
//       id: id ?? this.id,
//       userId: userId ?? this.userId,
//       productId: productId ?? this.productId,
//       product: product ?? this.product,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }

// class AddToWishlistRequestModel {
//   final String productId;

//   AddToWishlistRequestModel({required this.productId});

//   Map<String, dynamic> toJson() {
//     return {'product_id': productId};
//   }
// }
