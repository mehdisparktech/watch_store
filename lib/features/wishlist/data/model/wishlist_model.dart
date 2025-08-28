import 'package:watch_store/features/auth/data/model/user_model.dart';
import 'package:watch_store/features/brands/data/model/product_model.dart';

class BookmarkModel {
  final String? id;
  final DateTime? createdAt;
  final UserModel? user;
  final ProductModel? product;

  BookmarkModel({this.id, this.createdAt, this.user, this.product});

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: (json['id'] ?? json['_id'])?.toString(),
      createdAt:
          (json['created_at'] ?? json['createdAt']) != null
              ? DateTime.tryParse(
                (json['created_at'] ?? json['createdAt']).toString(),
              )
              : null,
      user:
          json['user'] != null
              ? UserModel.fromJson(Map<String, dynamic>.from(json['user']))
              : null,
      product:
          json['product'] != null
              ? ProductModel.fromJson(
                Map<String, dynamic>.from(json['product']),
              )
              : null,
    );
  }
}
