class ChatMessageModel {
  final DateTime time;
  final String text;
  final String image; // Profile image
  final bool isMe;
  final bool isCall;
  final bool isNotice;
  final bool isRead;
  final String sellerImage;
  final String? imageUrl; // Message image attachment
  final String? localImagePath; // Local image path before upload

  ChatMessageModel({
    required this.time,
    required this.text,
    required this.image,
    required this.isMe,
    this.isCall = false,
    this.isNotice = false,
    this.isRead = false,
    this.sellerImage = "",
    this.imageUrl,
    this.localImagePath,
  });
}
