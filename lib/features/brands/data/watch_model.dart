class WatchModel {
  final int id;
  final String name;
  final String price;
  final String imageUrl;
  bool isFavorite;

  WatchModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
