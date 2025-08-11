class FAQModel {
  final String? id;
  final String? question;
  final String? answer;
  final String? category;
  final int? order;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FAQModel({
    this.id,
    this.question,
    this.answer,
    this.category,
    this.order,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(
      id: json['id']?.toString(),
      question: json['question']?.toString(),
      answer: json['answer']?.toString(),
      category: json['category']?.toString(),
      order: json['order']?.toInt(),
      isActive: json['is_active'],
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
      'question': question,
      'answer': answer,
      'category': category,
      'order': order,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  FAQModel copyWith({
    String? id,
    String? question,
    String? answer,
    String? category,
    int? order,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FAQModel(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      category: category ?? this.category,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FAQCategoryModel {
  final String? name;
  final String? description;
  final int? faqCount;

  FAQCategoryModel({this.name, this.description, this.faqCount});

  factory FAQCategoryModel.fromJson(Map<String, dynamic> json) {
    return FAQCategoryModel(
      name: json['name']?.toString(),
      description: json['description']?.toString(),
      faqCount: json['faq_count']?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description, 'faq_count': faqCount};
  }
}
