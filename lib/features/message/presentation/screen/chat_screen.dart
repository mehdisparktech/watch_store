import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watch_store/component/app_bar/common_app_bar.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../component/other_widgets/common_loader.dart';
import '../../../../component/screen/error_screen.dart';
import '../controller/chat_controller.dart';
import '../../data/model/chat_list_model.dart';
import '../../../../../utils/enum/enum.dart';
import '../widgets/chat_list_item.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Modern App Bar Section
      appBar: CommonAppBar(
        title: 'Message',
        profileImageUrl: AppImages.profileImage,
      ),

      /// Body Section
      body: GetBuilder<ChatController>(
        builder:
            (controller) => switch (controller.status) {
              /// Loading state
              Status.loading => const CommonLoader(),

              /// Error state
              Status.error => ErrorScreen(
                onTap: ChatController.instance.getChatRepo,
              ),

              /// Main content
              Status.completed => Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: controller.chats.length,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemBuilder: (context, index) {
                    ChatModel item = controller.chats[index];
                    return GestureDetector(
                      onTap:
                          () => Get.toNamed(
                            AppRoutes.message,
                            parameters: {
                              "chatId": item.id,
                              "name": item.participant.fullName,
                              "image": item.participant.image,
                            },
                          ),
                      child: modernChatListItem(item: item),
                    );
                  },
                ),
              ),
            },
      ),
    );
  }
}
