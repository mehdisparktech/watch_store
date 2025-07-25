class ChatMessageModel {
  final DateTime time;
  final String text;
  final String image;
  final bool isMe;
  final bool isCall;
  final bool isNotice;
  final bool isRead;

  ChatMessageModel({
    required this.time,
    required this.text,
    required this.image,
    required this.isMe,
    this.isCall = false,
    this.isNotice = false,
    this.isRead = false,
  });
}
