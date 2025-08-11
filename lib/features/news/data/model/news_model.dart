class NewsModel {
  final String? id;
  final String? title;
  final String? content;
  final String? excerpt;
  final String? image;
  final String? author;
  final String? category;
  final List<String>? tags;
  final bool? isPublished;
  final DateTime? publishedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NewsModel({
    this.id,
    this.title,
    this.content,
    this.excerpt,
    this.image,
    this.author,
    this.category,
    this.tags,
    this.isPublished,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id']?.toString(),
      title: json['title']?.toString(),
      content: json['content']?.toString(),
      excerpt: json['excerpt']?.toString(),
      image: json['image']?.toString(),
      author: json['author']?.toString(),
      category: json['category']?.toString(),
      tags:
          json['tags'] != null
              ? List<String>.from(json['tags'].map((x) => x.toString()))
              : null,
      isPublished: json['is_published'],
      publishedAt:
          json['published_at'] != null
              ? DateTime.tryParse(json['published_at'].toString())
              : null,
      createdAt:
          json['created_at'] != null
              ? DateTime.tryParse(json['created_at'].toString())
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.tryParse(json['updated_at'].toString())
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'excerpt': excerpt,
      'image': image,
      'author': author,
      'category': category,
      'tags': tags,
      'is_published': isPublished,
      'published_at': publishedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  NewsModel copyWith({
    String? id,
    String? title,
    String? content,
    String? excerpt,
    String? image,
    String? author,
    String? category,
    List<String>? tags,
    bool? isPublished,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NewsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      excerpt: excerpt ?? this.excerpt,
      image: image ?? this.image,
      author: author ?? this.author,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      isPublished: isPublished ?? this.isPublished,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
