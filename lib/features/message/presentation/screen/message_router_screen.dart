import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import 'package:watch_store/utils/log/app_log.dart';
import 'chat_screen.dart';
import 'message_screen.dart';

/// Message Router Screen
/// Implements the flow diagram logic:
/// - Check if user is Admin or User
/// - Admin: Direct to chat list
/// - User: Check if messageId exists
///   - If messageId exists: Direct to message screen
///   - If no messageId: Show chat list
class MessageRouterScreen extends StatelessWidget {
  const MessageRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get parameters
    final String? messageId = Get.parameters["messageId"];
    final String? userId = Get.parameters["userId"];
    final String userRole = LocalStorage.role.toLowerCase();

    appLog("=== Message Router ===");
    appLog("User Role: $userRole");
    appLog("Message ID: $messageId");
    appLog("User ID: $userId");

    // Check user role
    if (userRole == "admin") {
      // Admin: Show chat list directly
      appLog("Routing to: Chat List (Admin)");
      return ChatListScreen();
    } else {
      // User: Check if messageId exists
      if (messageId != null && messageId.isNotEmpty) {
        // MessageId exists: Go to direct message screen
        appLog("Routing to: Direct Message Screen");

        // Get additional parameters for message screen
        final bool isItemChat = Get.arguments ?? false;

        return MessageScreen(key: ValueKey(messageId), isItemChat: isItemChat);
      } else if (userId != null && userId.isNotEmpty) {
        // UserId exists but no messageId: Create chat and go to message screen
        appLog("Routing to: Create Chat with User");

        final bool isItemChat = Get.arguments ?? false;

        return MessageScreen(key: ValueKey(userId), isItemChat: isItemChat);
      } else {
        // No messageId or userId: Show chat list
        appLog("Routing to: Chat List (User)");
        return ChatListScreen();
      }
    }
  }
}
