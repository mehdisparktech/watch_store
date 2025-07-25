import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_store/utils/constants/app_images.dart';
import '../../data/model/chat_list_model.dart';
// import '../../../../services/api/api_service.dart';
import '../../../../services/socket/socket_service.dart';
// import '../../../../config/api/api_end_point.dart';
import '../../../../services/storage/storage_services.dart';
// import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';

class ChatController extends GetxController {
  /// Api status check here
  Status status = Status.completed;

  /// Chat more Data Loading Bar
  bool isMoreLoading = false;

  /// page no here
  int page = 1;

  /// Chat List here
  List chats = [
    ChatModel(
      id: '1',
      participant: Participant(
        id: 'user1',
        fullName: 'John Smith',
        image: AppImages.profileImage,
      ),
      latestMessage: LatestMessage(
        id: 'msg1',
        message: 'Hey! Are you interested in the Rolex watch?',
        createdAt: DateTime.now().subtract(Duration(minutes: 5)),
        isFromMe: true,
        isRead: true,
      ),
      unreadCount: 0,
    ),
    ChatModel(
      id: '2',
      participant: Participant(
        id: 'user2',
        fullName: 'Sarah Johnson',
        image: AppImages.profileImage,
      ),
      latestMessage: LatestMessage(
        id: 'msg2',
        message: 'Thanks for the quick delivery!',
        createdAt: DateTime.now().subtract(Duration(hours: 2)),
        isFromMe: false,
        isRead: true,
      ),
      unreadCount: 0,
    ),
    ChatModel(
      id: '3',
      participant: Participant(
        id: 'user3',
        fullName: 'Mike Wilson',
        image: AppImages.profileImage,
      ),
      latestMessage: LatestMessage(
        id: 'msg3',
        message: 'Do you have this model in silver?',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        isFromMe: false,
        isRead: true,
      ),
      unreadCount: 0,
    ),
  ];

  /// Chat Scroll Controller
  ScrollController scrollController = ScrollController();

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
    return;
    // if (page == 1) {
    //   status = Status.loading;
    //   update();
    // }

    // var response = await ApiService.get("${ApiEndPoint.chats}?page=$page");

    // if (response.statusCode == 200) {
    //   var data = response.data['chats'] ?? [];

    //   for (var item in data) {
    //     chats.add(ChatModel.fromJson(item));
    //   }

    //   page = page + 1;
    //   status = Status.completed;
    //   update();
    // } else {
    //   Utils.errorSnackBar(response.statusCode.toString(), response.message);
    //   status = Status.error;
    //   update();
    // }
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
