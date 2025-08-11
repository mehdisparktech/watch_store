import '../data/model/message_model.dart';

abstract class MessageRepository {
  Future<List<ConversationModel>> getConversations();
  Future<List<MessageModel>> getMessages(String conversationId);
  Future<MessageModel> sendMessage(SendMessageRequestModel request);
  Future<bool> markAsRead(String messageId);
  Future<bool> deleteMessage(String messageId);
  Future<int> getUnreadCount();
}

class MessageRepositoryImpl implements MessageRepository {
  // final ApiService _apiService;
  // final SocketService _socketService;
  // MessageRepositoryImpl(this._apiService, this._socketService);

  @override
  Future<List<ConversationModel>> getConversations() async {
    try {
      // final response = await _apiService.get('/conversations');
      // return (response.data['data'] as List)
      //     .map((json) => ConversationModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get conversations: $e');
    }
  }

  @override
  Future<List<MessageModel>> getMessages(String conversationId) async {
    try {
      // final response = await _apiService.get('/conversations/$conversationId/messages');
      // return (response.data['data'] as List)
      //     .map((json) => MessageModel.fromJson(json))
      //     .toList();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }

  @override
  Future<MessageModel> sendMessage(SendMessageRequestModel request) async {
    try {
      // final response = await _apiService.post('/messages', data: request.toJson());
      // final message = MessageModel.fromJson(response.data['data']);

      // Emit to socket for real-time delivery
      // _socketService.emit('send_message', message.toJson());

      // return message;

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  @override
  Future<bool> markAsRead(String messageId) async {
    try {
      // await _apiService.put('/messages/$messageId/read');
      // return true;

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to mark message as read: $e');
    }
  }

  @override
  Future<bool> deleteMessage(String messageId) async {
    try {
      // await _apiService.delete('/messages/$messageId');
      // return true;

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }

  @override
  Future<int> getUnreadCount() async {
    try {
      // final response = await _apiService.get('/messages/unread-count');
      // return response.data['data']['count'];

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get unread count: $e');
    }
  }
}
