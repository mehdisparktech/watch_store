import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_store/utils/log/app_log.dart';
import '../../data/model/chat_message_model.dart';
import '../../data/model/message_model.dart';

import '../../../../services/api/api_service.dart';
import '../../../../services/socket/socket_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';

class MessageController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;
  String? video;
  bool isItemChat = false;

  List messages = [];

  String chatId = "";
  String name = "";
  String peerImage = "";
  String sellerImage = "";

  int page = 1;
  int currentIndex = 0;
  Status status = Status.completed;

  bool isMessage = false;
  bool isInputField = false;

  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  static MessageController get instance => Get.put(MessageController());

  MessageModel messageModel = MessageModel.fromJson({});

  Future<void> getMessageRepo() async {
    try {
      if (page == 1) {
        messages.clear();
        status = Status.loading;
        update();
      }

      final response = await ApiService.get(
        "${ApiEndPoint.messages}/$chatId?page=$page&limit=15",
      );

      if (response.isSuccess) {
        final Map root = (response.data);
        final Map data = (root['data'] ?? {}) as Map;
        final List rawMessages = (data['messages'] ?? []) as List;

        for (final dynamic raw in rawMessages) {
          final Map item = (raw ?? {}) as Map;
          final Map sender = (item['sender'] ?? {}) as Map;
          final String text =
              (item['text'] ?? item['message'] ?? '').toString();
          // final String senderId =
          //     (sender['_id'] ?? sender['id'] ?? '').toString();
          final String senderEmail =
              (sender['email'] ?? sender['email'] ?? '').toString();
          final String otherImage = peerImage;
          // final String myImage = LocalStorage.myImage;
          final DateTime createdAt =
              DateTime.tryParse((item['createdAt'] ?? '').toString()) ??
              DateTime.now();

          messages.add(
            ChatMessageModel(
              time: createdAt.toLocal(),
              text: text,
              image:
                  senderEmail == LocalStorage.myEmail
                      ? LocalStorage.myImage
                      : otherImage,
              isMe: senderEmail == LocalStorage.myEmail,
              isNotice: (item['type'] ?? '') == 'notice',
              isRead: (item['read'] ?? false) == true,
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

  Future<void> createChat() async {
    final response = await ApiService.post(
      ApiEndPoint.createChat,
      body: {
        "participant": [chatId],
      },
    );

    if (response.isSuccess) {
      final Map root = (response.data);
      final Map data = (root['data'] ?? {}) as Map;
      final String chatId = (data['_id'] ?? '').toString();
      this.chatId = chatId;
      getMessageRepo();
    } else {
      Utils.errorSnackBar(response.statusCode.toString(), response.message);
    }
  }

  addNewMessage({String? imagePath}) async {
    isMessage = true;
    update();

    messages.insert(
      0,
      ChatMessageModel(
        time: DateTime.now(),
        text: messageController.text,
        image: LocalStorage.myImage,
        isMe: true,
      ),

      // ChatMessageModel(
      //     currentTime.format(context).toString(),
      //     controller.messageController.text,
      //     true),
    );

    isMessage = false;
    update();

    final String text = messageController.text;
    messageController.clear();

    try {
      // Build multipart body: data (json string), images (file)
      final Map<String, String> body = {
        'data': '{"text":"${text.replaceAll("\"", "\\\"")}"}',
      };

      final result = await ApiService.multipart(
        "${ApiEndPoint.baseUrl}messages/send-message/$chatId",
        body: body,
        imageName: 'images',
        imagePath: imagePath,
        header: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (!result.isSuccess) {
        Utils.errorSnackBar(result.statusCode.toString(), result.message);
      }
    } catch (e) {
      Utils.errorSnackBar('Error', e.toString());
    }
  }

  listenMessage(String chatId) async {
    appLog("Setting up message listener for chat: $chatId");
    appLog("User ID: ${LocalStorage.userId}");
    appLog("User Email: ${LocalStorage.myEmail}");

    // Remove any existing listeners first
    SocketServices.off('newMessage::${LocalStorage.userId}');
    SocketServices.off('message::$chatId');

    // Set up the message listener
    SocketServices.on('newMessage::${LocalStorage.userId}', (data) {
      try {
        appLog("Received new message: $data");

        final String text = (data['text'] ?? data['message'] ?? '').toString();
        final String senderEmail = (data['sender']?['email'] ?? '').toString();
        final String avatar =
            senderEmail == LocalStorage.myEmail
                ? LocalStorage.myImage
                : peerImage;
        final DateTime createdAt =
            DateTime.tryParse((data['createdAt'] ?? '').toString()) ??
            DateTime.now();

        // Only add message if it belongs to current chat
        final String messageChatId =
            (data['chatId'] ?? data['chat'] ?? '').toString();
        if (messageChatId == chatId || messageChatId.isEmpty) {
          messages.insert(
            0,
            ChatMessageModel(
              isNotice: (data['type'] ?? data['messageType'] ?? '') == "notice",
              time: createdAt.toLocal(),
              text: text,
              image: avatar,
              isMe: senderEmail == LocalStorage.myEmail,
              isRead: (data['read'] ?? false) == true,
            ),
          );

          status = Status.completed;
          update();
          appLog("Message added to chat");
        } else {
          appLog("Message ignored - different chat ID");
        }
      } catch (e) {
        appLog("Error processing new message: $e");
      }
    });

    // Also listen for chat-specific events (alternative event format)
    SocketServices.on('message::$chatId', (data) {
      try {
        appLog("Received chat-specific message: $data");

        final String text = (data['text'] ?? data['message'] ?? '').toString();
        final String senderEmail = (data['sender']?['email'] ?? '').toString();
        final String avatar =
            senderEmail == LocalStorage.myEmail
                ? LocalStorage.myImage
                : peerImage;
        final DateTime createdAt =
            DateTime.tryParse((data['createdAt'] ?? '').toString()) ??
            DateTime.now();

        messages.insert(
          0,
          ChatMessageModel(
            isNotice: (data['type'] ?? data['messageType'] ?? '') == "notice",
            time: createdAt.toLocal(),
            text: text,
            image: avatar,
            isMe: senderEmail == LocalStorage.myEmail,
            isRead: (data['read'] ?? false) == true,
          ),
        );

        status = Status.completed;
        update();
        appLog("Chat-specific message added");
      } catch (e) {
        appLog("Error processing chat-specific message: $e");
      }
    });

    // Check socket connection status
    if (!SocketServices.isConnected) {
      appLog("Socket not connected, attempting to reconnect...");
      SocketServices.reconnect();
    }
  }

  void isEmoji(int index) {
    currentIndex = index;
    isInputField = isInputField;
    update();
  }

  /// Clean up socket listeners when leaving chat
  void cleanupListeners() {
    try {
      SocketServices.off('newMessage::${LocalStorage.userId}');
      SocketServices.off('message::$chatId');
      appLog("Socket listeners cleaned up");
    } catch (e) {
      appLog("Error cleaning up listeners: $e");
    }
  }

  /// Test socket connection and setup
  void testSocketConnection() {
    appLog("=== Socket Connection Test ===");
    appLog("Socket connected: ${SocketServices.isConnected}");
    appLog("User ID: ${LocalStorage.userId}");
    appLog("Chat ID: $chatId");
    appLog("Listening for: newMessage::${LocalStorage.userId}");
    appLog("Also listening for: message::$chatId");

    if (!SocketServices.isConnected) {
      appLog("Attempting to reconnect socket...");
      SocketServices.reconnect();
    }
  }

  @override
  void onClose() {
    cleanupListeners();
    scrollController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
