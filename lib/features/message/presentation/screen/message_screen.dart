import 'package:flutter/material.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_icons.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../data/model/chat_message_model.dart';
import '../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/message_controller.dart';
import '../widgets/chat_bubble_message.dart';

class MessageScreen extends StatefulWidget {
  final bool isItemChat;
  const MessageScreen({super.key, this.isItemChat = false});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String chatId = Get.parameters["chatId"] ?? "";
  String name = Get.parameters["name"] ?? "";
  String image = Get.parameters["image"] ?? "";
  String? itemImage = Get.parameters["itemImage"];
  String? itemPrice = Get.parameters["itemPrice"];
  String? itemName = Get.parameters["itemName"];

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
          body:
              widget.isItemChat
                  ? _buildItemChatScreen(controller)
                  : _buildNormalChatScreen(controller),
        );
      },
    );
  }

  Widget _buildNormalChatScreen(MessageController controller) {
    return Scaffold(
      /// Modern App Bar
      appBar: _buildNormalAppBar(),

      /// Chat Messages Body
      body: _buildChatBody(controller),

      /// Message Input Bottom Bar
      bottomNavigationBar: _buildMessageInput(controller),
    );
  }

  Widget _buildItemChatScreen(MessageController controller) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          // SliverAppBar for Item Chat
          SliverAppBar(
            expandedHeight: 400.h,
            pinned: true,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
              onPressed: () => Get.back(),
            ),

            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Item Image
                  Column(
                    children: [
                      SizedBox(height: 50.h),
                      CommonText(
                        text: itemName ?? "Omega",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontFamily: 'PlayfairDisplay',
                      ),
                      SizedBox(height: 14.h),
                      CommonImage(
                        imageSrc: itemImage ?? AppImages.omega,
                        size: 180,
                      ),
                      SizedBox(height: 14.h),
                      CommonText(
                        text: itemPrice ?? "\$25,000",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.socialIconBackground,
                      ),
                    ],
                  ),

                  // Name and online status at the bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      color: Colors.white,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.grey[300],
                            child: ClipOval(
                              child: CommonImage(imageSrc: image, size: 40),
                            ),
                          ),
                          12.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                  text: name,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black,
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
                    ),
                  ),
                ],
              ),

              titlePadding: EdgeInsets.only(left: 50.w, bottom: 16.h),
              collapseMode: CollapseMode.pin,
            ),
          ),

          // Chat messages in a SliverList
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index < controller.messages.length) {
                    ChatMessageModel message = controller.messages[index];
                    return ModernChatBubble(
                      message: message,
                      isMe: message.isMe,
                      showAvatar: _shouldShowAvatar(controller.messages, index),
                    );
                  } else if (controller.isMoreLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return null;
                },
                childCount:
                    controller.isMoreLoading
                        ? controller.messages.length + 1
                        : controller.messages.length,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildMessageInput(controller),
    );
  }

  AppBar _buildNormalAppBar() {
    return AppBar(
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
                child: ClipOval(child: CommonImage(imageSrc: image, size: 40)),
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
    );
  }

  Widget _buildChatBody(MessageController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        /// Messages List
        Expanded(
          child: ListView.builder(
            reverse: true,
            controller: controller.scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemCount:
                controller.isMoreLoading
                    ? controller.messages.length + 1
                    : controller.messages.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < controller.messages.length) {
                ChatMessageModel message = controller.messages[index];
                return ModernChatBubble(
                  message: message,
                  isMe: message.isMe,
                  showAvatar: _shouldShowAvatar(controller.messages, index),
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
    );
  }

  Widget _buildMessageInput(MessageController controller) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          children: [
            /// Input Container
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2.h),
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
                        color: AppColors.socialIconBackground,
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
                        onSubmitted: (value) => controller.addNewMessage(),
                        maxLines: null,
                      ),
                    ),

                    /// Camera Button
                    IconButton(
                      icon: CommonImage(
                        imageSrc: AppIcons.image,
                        size: 24,
                        imageColor: Colors.grey[600],
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
                color: AppColors.socialIconBackground,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: CommonImage(
                  imageSrc: AppIcons.send,
                  size: 24,
                  imageColor: Colors.white,
                ),
                onPressed: controller.addNewMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _shouldShowAvatar(List<dynamic> messages, int index) {
    if (index == messages.length - 1) return true;

    final currentMessage = messages[index] as ChatMessageModel;
    final nextMessage = messages[index + 1] as ChatMessageModel;

    return currentMessage.isMe != nextMessage.isMe;
  }
}
