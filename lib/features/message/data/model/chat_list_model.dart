class ChatModel {
  final String id;
  final Participant participant;
  final int unreadCount;
  final LatestMessage latestMessage;

  ChatModel({
    required this.id,
    required this.participant,
    required this.latestMessage,
    required this.unreadCount,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['_id'] ?? '',
      participant: Participant.fromJson(json['participant'] ?? {}),
      latestMessage: LatestMessage.fromJson(json['latestMessage'] ?? {}),
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}

class Participant {
  final String id;
  final String fullName;
  final String email;
  final String image;

  Participant({
    required this.id,
    required this.fullName,
    required this.email,
    required this.image,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'] ?? '',
      fullName: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['profileImage'] ?? '',
    );
  }
}

class LatestMessage {
  final String id;
  final String message;
  final DateTime createdAt;
  final bool isFromMe;
  final bool isRead;

  LatestMessage({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.isFromMe,
    required this.isRead,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) {
    return LatestMessage(
      id: json['_id'] ?? '',
      message: json['message'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      isFromMe: json['isFromMe'] ?? false,
      isRead: json['isRead'] ?? false,
    );
  }
}
