class FAQModel {
  final String? id;
  final String? question;
  final String? answer;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FAQModel({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(
      id: json['_id']?.toString(),
      question: json['question']?.toString(),
      answer: json['answer']?.toString(),
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
      'question': question,
      'answer': answer,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class FAQResponse {
  final bool success;
  final String message;
  final int statusCode;
  final List<FAQModel> data;

  FAQResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory FAQResponse.fromJson(Map<String, dynamic> json) {
    return FAQResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      data: (json['data'] as List?)
              ?.map((e) => FAQModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
