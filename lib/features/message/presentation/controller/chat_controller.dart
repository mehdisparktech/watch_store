import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/chat_list_model.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/socket/socket_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';
import '../../../../utils/log/app_log.dart';

class ChatController extends GetxController {
  /// Api status check here
  Status status = Status.completed;

  /// Chat more Data Loading Bar
  bool isMoreLoading = false;

  /// page no here
  int page = 1;

  /// Chat List here
  List<ChatModel> chats = [];

  /// Chat Scroll Controller
  ScrollController scrollController = ScrollController();

  /// Check if user is admin
  bool get isAdmin => LocalStorage.role.toLowerCase() == 'admin';

  /// Chat Controller Instance create here
  static ChatController get instance => Get.put(ChatController());

  /// Chat More data Loading function
  Future<void> moreChats() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await getChatRepo();
      isMoreLoading = false;
      update();
    }
  }

  /// Chat data Loading function
  Future<void> getChatRepo() async {
    try {
      if (page == 1) {
        status = Status.loading;
        update();
      }

      appLog("=== Loading Chat List ===");
      appLog("User Role: ${LocalStorage.role}");
      appLog("Is Admin: $isAdmin");
      appLog("Page: $page");

      final response = await ApiService.get("${ApiEndPoint.chats}?page=$page");

      if (response.isSuccess) {
        final root = response.data;
        final data = (root['data'] ?? {}) as Map;
        final List chatsList = (data['chats'] ?? []) as List;

        if (page == 1) {
          chats.clear();
        }

        for (final dynamic raw in chatsList) {
          final Map item = (raw ?? {}) as Map;

          // Map API -> UI model
          final Map last = (item['lastMessage'] ?? {}) as Map;
          final List participants = (item['participants'] ?? []) as List;
          final Map participantRaw =
              participants.isNotEmpty ? (participants.first as Map) : {};

          final participant = Participant(
            id: (participantRaw['_id'] ?? '').toString(),
            fullName: (participantRaw['name'] ?? '').toString(),
            email: (participantRaw['email'] ?? ''),
            image: (participantRaw['profileImage'] ?? '').toString(),
          );

          final latestMessage = LatestMessage(
            id: (last['_id'] ?? '').toString(),
            message: (last['text'] ?? last['message'] ?? '').toString(),
            createdAt:
                DateTime.tryParse((last['createdAt'] ?? '').toString()) ??
                DateTime.now(),
            isFromMe: (last['sender']?.toString() ?? '') == LocalStorage.userId,
            isRead: (last['read'] ?? false) == true,
          );

          chats.add(
            ChatModel(
              id: (item['_id'] ?? '').toString(),
              participant: participant,
              latestMessage: latestMessage,
              unreadCount:
                  int.tryParse((item['unreadCount'] ?? 0).toString()) ?? 0,
            ),
          );
        }

        page = page + 1;
        status = Status.completed;
        update();
      } else {
        Utils.errorSnackBar(response.statusCode.toString(), response.message);
        status = Status.error;
        update();
      }
    } catch (e) {
      Utils.errorSnackBar('Error', e.toString());
      status = Status.error;
      update();
    }
  }

  /// Chat data Update  Socket listener
  listenChat() async {
    SocketServices.on("update-chatlist::${LocalStorage.userId}", (data) {
      page = 1;
      chats.clear();

      for (var item in data) {
        chats.add(ChatModel.fromJson(item));
      }

      status = Status.completed;
      update();
    });
  }

  /// Controller on Init¬
  @override
  void onInit() {
    getChatRepo();
    super.onInit();
  }
}
