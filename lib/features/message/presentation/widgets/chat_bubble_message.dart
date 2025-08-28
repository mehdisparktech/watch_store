import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../data/model/chat_message_model.dart';
import '../../../../utils/extensions/extension.dart';

class ModernChatBubble extends StatelessWidget {
  final ChatMessageModel message;
  final bool isMe;
  final bool showAvatar;

  const ModernChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.showAvatar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// Other person's avatar (left side)
          if (!isMe && showAvatar) ...[
            CircleAvatar(
              radius: 16.r,
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child: CommonImage(
                  imageSrc: ApiEndPoint.imageUrl + message.image,
                  size: 32,
                ),
              ),
            ),
            8.width,
          ] else if (!isMe && !showAvatar) ...[
            SizedBox(width: 40.w), // Spacing for grouped messages
          ],

          /// Message Bubble
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: Get.width * 0.75,
                    minWidth: 60.w,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isMe
                            ? AppColors.socialIconBackground
                            : AppColors.filledColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                      bottomLeft: Radius.circular(isMe ? 12.r : 0.r),
                      bottomRight: Radius.circular(isMe ? 0.r : 12.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child:
                  /// Message Text
                  CommonText(
                    text: message.text,
                    fontSize: 15,
                    color: isMe ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                4.height,

                /// Time and Status Row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /// Message Status (only for sent messages)
                    if (isMe) ...[
                      4.width,
                      Icon(
                        message.isRead == true ? Icons.done_all : Icons.done,
                        // ignore: deprecated_member_use
                        size: 14.sp,
                        color:
                            message.isRead == true ? Colors.grey : Colors.grey,
                      ),
                    ],
                    4.width,
                    CommonText(
                      text: _formatMessageTime(message.time),
                      fontSize: 11,
                      color: isMe ? Colors.grey : AppColors.secondary,
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// My avatar (right side) - Optional
        ],
      ),
    );
  }

  String _formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();
    final messageDate = dateTime.toLocal();

    // If message is from today
    if (now.day == messageDate.day &&
        now.month == messageDate.month &&
        now.year == messageDate.year) {
      final hour = messageDate.hour;
      final minute = messageDate.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

      return '$displayHour:$minute $period';
    }

    // If message is from yesterday
    final yesterday = now.subtract(const Duration(days: 1));
    if (yesterday.day == messageDate.day &&
        yesterday.month == messageDate.month &&
        yesterday.year == messageDate.year) {
      return 'Yesterday';
    }

    // For older messages
    return '${messageDate.day}/${messageDate.month}/${messageDate.year}';
  }
}

/// Enhanced Chat Bubble for Complex Messages (with images, files, etc.)
class AdvancedChatBubble extends StatelessWidget {
  final ChatMessageModel message;
  final bool isMe;
  final bool showAvatar;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const AdvancedChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.showAvatar = true,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// Other person's avatar
            if (!isMe && showAvatar) ...[
              CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: CommonImage(imageSrc: message.image, size: 32),
                ),
              ),
              8.width,
            ] else if (!isMe && !showAvatar) ...[
              SizedBox(width: 40.w),
            ],

            /// Message Content
            Flexible(
              child: Container(
                constraints: BoxConstraints(maxWidth: Get.width * 0.75),
                decoration: BoxDecoration(
                  color: isMe ? Colors.orange : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.r),
                    topRight: Radius.circular(18.r),
                    bottomLeft: Radius.circular(isMe ? 18.r : 4.r),
                    bottomRight: Radius.circular(isMe ? 4.r : 18.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Image/Media Content (if any)
                    if (message.image.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.r),
                          topRight: Radius.circular(18.r),
                        ),
                        child: CommonImage(
                          imageSrc: message.image,
                          fill: BoxFit.cover,
                          width: double.infinity,
                          height: 200.h,
                        ),
                      ),

                    /// Text Content
                    if (message.text.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: message.text,
                              fontSize: 15,
                              color: isMe ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),

                            8.height,

                            /// Time and Status
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CommonText(
                                  text: _formatMessageTime(message.time),
                                  fontSize: 11,
                                  color:
                                      isMe
                                          // ignore: deprecated_member_use
                                          ? AppColors.socialIcon
                                          : AppColors.secondary,
                                ),

                                if (isMe) ...[
                                  4.width,
                                  Icon(
                                    message.isRead == true
                                        ? Icons.done_all
                                        : Icons.done,
                                    size: 14.sp,
                                    color:
                                        message.isRead == true
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.8),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            /// My avatar (optional)
            if (isMe && showAvatar) ...[
              8.width,
              CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: CommonImage(imageSrc: message.image, size: 32),
                ),
              ),
            ] else if (isMe && !showAvatar) ...[
              SizedBox(width: 40.w),
            ],
          ],
        ),
      ),
    );
  }

  String _formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();
    final messageDate = dateTime.toLocal();

    if (now.day == messageDate.day &&
        now.month == messageDate.month &&
        now.year == messageDate.year) {
      final hour = messageDate.hour;
      final minute = messageDate.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

      return '$displayHour:$minute $period';
    }

    final yesterday = now.subtract(const Duration(days: 1));
    if (yesterday.day == messageDate.day &&
        yesterday.month == messageDate.month &&
        yesterday.year == messageDate.year) {
      return 'Yesterday';
    }

    return '${messageDate.day}/${messageDate.month}/${messageDate.year}';
  }
}
