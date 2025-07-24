import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../data/model/chat_list_model.dart';
import '../../../../utils/extensions/extension.dart';
import '../../../../utils/constants/app_colors.dart';

Widget modernChatListItem({required ChatModel item}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    decoration: const BoxDecoration(color: Colors.white),
    child: Row(
      children: [
        /// Profile Image with Online Status
        Stack(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: CommonImage(imageSrc: item.participant.image, size: 56),
              ),
            ),
            // Online status indicator (green dot)
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),

        16.width,

        /// Chat Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Participant Name
                  Expanded(
                    child: CommonText(
                      text: item.participant.fullName,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),

                  /// Time
                  CommonText(
                    text: _formatTime(item.latestMessage.createdAt),
                    fontSize: 14,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),

              6.height,

              /// Last Message with Status and Badge
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        // Message text with emoji
                        Expanded(
                          child: CommonText(
                            text: item.latestMessage.message,
                            fontSize: 16,
                            color: AppColors.secondary,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        /// Message Status (Read/Delivered) - only for sent messages
                        if (item.latestMessage.isFromMe == true) ...[
                          4.width,
                          Icon(
                            item.latestMessage.isRead == true
                                ? Icons.done_all
                                : Icons.done,
                            size: 16.sp,
                            color:
                                item.latestMessage.isRead == true
                                    ? Colors.blue
                                    : Colors.grey[400],
                          ),
                        ],
                      ],
                    ),
                  ),

                  /// Unread message count badge
                  if (item.unreadCount > 0) ...[
                    8.width,
                    Container(
                      width: 24.w,
                      height: 24.h,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: CommonText(
                          text: item.unreadCount.toString(),
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

String _formatTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 0) {
    if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${difference.inDays}d ago';
    }
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m ago';
  } else {
    return 'Now';
  }
}
