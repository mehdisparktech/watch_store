import 'package:flutter/material.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../data/model/chat_message_model.dart';
import '../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/message_controller.dart';
import '../widgets/chat_bubble_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String chatId = Get.parameters["chatId"] ?? "";
  String name = Get.parameters["name"] ?? "";
  String image = Get.parameters["image"] ?? "";

  @override
  void initState() {
    MessageController.instance.name = name;
    MessageController.instance.chatId = chatId;
    MessageController.instance.getMessageRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        return Scaffold(
          /// Modern App Bar
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
              onPressed: () => Get.back(),
            ),
            title: Row(
              children: [
                /// Participant Image
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: Colors.grey[300],
                      child: ClipOval(
                        child: CommonImage(imageSrc: image, size: 40),
                      ),
                    ),
                    // Online status
                    Positioned(
                      bottom: 0,
                      right: 0,
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

                12.width,

                /// Participant Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: name,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      CommonText(
                        text: 'Online',
                        fontSize: 12,
                        color: AppColors.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.phone, color: Colors.white, size: 24.sp),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.video_call, color: Colors.white, size: 24.sp),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.white, size: 24.sp),
                onPressed: () {},
              ),
            ],
          ),

          /// Chat Messages Body
          body:
              controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    children: [
                      /// Messages List
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: controller.scrollController,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          itemCount:
                              controller.isMoreLoading
                                  ? controller.messages.length + 1
                                  : controller.messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < controller.messages.length) {
                              ChatMessageModel message =
                                  controller.messages[index];
                              return ModernChatBubble(
                                message: message,
                                isMe: message.isMe,
                                showAvatar: _shouldShowAvatar(
                                  controller.messages as List<ChatMessageModel>,
                                  index,
                                ),
                              );
                            } else {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),

          /// Message Input Bottom Bar
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                children: [
                  /// Input Container
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xffF5F6FA),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          /// Emoji Button
                          IconButton(
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.grey[600],
                              size: 24.sp,
                            ),
                            onPressed: () {},
                          ),

                          /// Text Input Field
                          Expanded(
                            child: TextField(
                              controller: controller.messageController,
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14.sp,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                              ),
                              onSubmitted:
                                  (value) => controller.addNewMessage(),
                              maxLines: null,
                            ),
                          ),

                          /// Camera Button
                          IconButton(
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.grey[600],
                              size: 24.sp,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),

                  16.width,

                  /// Send Button
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white, size: 20.sp),
                      onPressed: controller.addNewMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _shouldShowAvatar(List<ChatMessageModel> messages, int index) {
    if (index == messages.length - 1) return true;

    final currentMessage = messages[index];
    final nextMessage = messages[index + 1];

    return currentMessage.isMe != nextMessage.isMe;
  }
}
