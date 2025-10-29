import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/utils/constants/app_colors.dart';
import 'package:watch_store/utils/constants/app_icons.dart';
import 'package:watch_store/utils/enum/enum.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../data/model/chat_message_model.dart';
import '../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/message_controller.dart';
import '../widgets/chat_bubble_message.dart';

class MessageScreenUser extends StatefulWidget {
  final bool isItemChat;
  const MessageScreenUser({super.key, this.isItemChat = false});

  @override
  State<MessageScreenUser> createState() => _MessageScreenUserState();
}

class _MessageScreenUserState extends State<MessageScreenUser> {
  String chatId = Get.parameters["chatId"] ?? "";
  String name = Get.parameters["name"] ?? "";
  String image = Get.parameters["image"] ?? "";
  String? itemImage = Get.parameters["itemImage"];
  String? itemPrice = Get.parameters["itemPrice"];
  String? itemName = Get.parameters["itemName"];
  bool _isEmojiVisible = false;
  final FocusNode _inputFocusNode = FocusNode();

  @override
  void initState() {
    MessageController.instance.isItemChat = widget.isItemChat;
    MessageController.instance.name = name;
    MessageController.instance.chatId = chatId;
    MessageController.instance.peerImage = image;
    MessageController.instance.sellerImage = image; // Set seller image
    MessageController.instance.page = 1;
    if (!widget.isItemChat) MessageController.instance.getMessageRepo();
    if (widget.isItemChat) MessageController.instance.createChat();

    // Add a small delay to ensure socket is connected before setting up listeners
    Future.delayed(const Duration(milliseconds: 1000), () {
      MessageController.instance.listenMessage(chatId);
    });

    // Scroll to bottom after screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        MessageController.instance.scrollToBottom();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _inputFocusNode.dispose();
    // Clean up socket listeners when leaving the screen
    MessageController.instance.cleanupListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        return Scaffold(body: _buildNormalChatScreen(controller));
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

  AppBar _buildNormalAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
        onPressed: () => Get.back(),
      ),
      title: Row(
        children: [
          /// Participant Image
          GetBuilder<MessageController>(
            builder: (controller) {
              if (controller.status == Status.loading) {
                return CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.grey[300],
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }
              return Stack(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.grey[300],
                    child: ClipOval(
                      child: CommonImage(
                        imageSrc:
                            controller.peerImage.isNotEmpty
                                ? ApiEndPoint.imageUrl + controller.peerImage
                                : ApiEndPoint.imageUrl + image,
                        size: 40,
                      ),
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
              );
            },
          ),

          12.width,

          /// Participant Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<MessageController>(
                  builder: (controller) {
                    if (controller.status == Status.loading) {
                      return Container(
                        width: 120,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }
                    return CommonText(
                      text: controller.name.isNotEmpty ? controller.name : name,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    );
                  },
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
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
                          onPressed: () {
                            setState(() {
                              _isEmojiVisible = !_isEmojiVisible;
                            });
                            if (_isEmojiVisible) {
                              FocusScope.of(context).unfocus();
                            } else {
                              _inputFocusNode.requestFocus();
                            }
                          },
                        ),

                        /// Text Input Field
                        Expanded(
                          child: TextField(
                            focusNode: _inputFocusNode,
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
                            onTap: () {
                              if (_isEmojiVisible) {
                                setState(() {
                                  _isEmojiVisible = false;
                                });
                              }
                            },
                            onSubmitted: (value) => controller.addNewMessage(),
                            maxLines: null,
                          ),
                        ),

                        /// Image Button
                        IconButton(
                          icon: CommonImage(
                            imageSrc: AppIcons.image,
                            size: 24,
                            imageColor: Colors.grey[600],
                          ),
                          onPressed: _showImageSourceActionSheet,
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

          /// Emoji Picker
          if (_isEmojiVisible)
            SizedBox(
              height: 280.h,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  final text = controller.messageController.text;
                  controller.messageController.text = text + emoji.emoji;
                  controller
                      .messageController
                      .selection = TextSelection.fromPosition(
                    TextPosition(
                      offset: controller.messageController.text.length,
                    ),
                  );
                },
                onBackspacePressed: () {
                  final text = controller.messageController.text;
                  if (text.isNotEmpty) {
                    controller.messageController.text =
                        text.characters.skipLast(1).toString();
                    controller
                        .messageController
                        .selection = TextSelection.fromPosition(
                      TextPosition(
                        offset: controller.messageController.text.length,
                      ),
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }

  bool _shouldShowAvatar(List<dynamic> messages, int index) {
    if (index == messages.length - 1) return true;

    final currentMessage = messages[index] as ChatMessageModel;
    final nextMessage = messages[index + 1] as ChatMessageModel;

    return currentMessage.isMe != nextMessage.isMe;
  }

  Future<void> _showImageSourceActionSheet() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (file == null) return;

      await MessageController.instance.addNewMessage(imagePath: file.path);
    } catch (_) {}
  }
}
