class MessageModel {
  final String? id;
  final String? senderId;
  final String? receiverId;
  final String? content;
  final String? type; // 'text', 'image', 'file'
  final String? attachmentUrl;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MessageModel({
    this.id,
    this.senderId,
    this.receiverId,
    this.content,
    this.type,
    this.attachmentUrl,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id']?.toString(),
      senderId: json['sender_id']?.toString(),
      receiverId: json['receiver_id']?.toString(),
      content: json['content']?.toString(),
      type: json['type']?.toString(),
      attachmentUrl: json['attachment_url']?.toString(),
      isRead: json['is_read'],
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
      'sender_id': senderId,
      'receiver_id': receiverId,
      'content': content,
      'type': type,
      'attachment_url': attachmentUrl,
      'is_read': isRead,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  MessageModel copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? content,
    String? type,
    String? attachmentUrl,
    bool? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      type: type ?? this.type,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ConversationModel {
  final String? id;
  final String? participantId;
  final String? participantName;
  final String? participantImage;
  final MessageModel? lastMessage;
  final int? unreadCount;
  final DateTime? updatedAt;

  ConversationModel({
    this.id,
    this.participantId,
    this.participantName,
    this.participantImage,
    this.lastMessage,
    this.unreadCount,
    this.updatedAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id']?.toString(),
      participantId: json['participant_id']?.toString(),
      participantName: json['participant_name']?.toString(),
      participantImage: json['participant_image']?.toString(),
      lastMessage:
          json['last_message'] != null
              ? MessageModel.fromJson(json['last_message'])
              : null,
      unreadCount: json['unread_count']?.toInt(),
      updatedAt:
          json['updated_at'] != null
              ? DateTime.tryParse(json['updated_at'].toString())
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participant_id': participantId,
      'participant_name': participantName,
      'participant_image': participantImage,
      'last_message': lastMessage?.toJson(),
      'unread_count': unreadCount,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class SendMessageRequestModel {
  final String receiverId;
  final String content;
  final String type;
  final String? attachmentPath;

  SendMessageRequestModel({
    required this.receiverId,
    required this.content,
    required this.type,
    this.attachmentPath,
  });

  Map<String, dynamic> toJson() {
    return {
      'receiver_id': receiverId,
      'content': content,
      'type': type,
      if (attachmentPath != null) 'attachment_path': attachmentPath,
    };
  }
}
