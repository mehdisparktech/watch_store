import 'package:watch_store/utils/log/app_log.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../config/api/api_end_point.dart';
import '../notification/notification_service.dart';
import '../storage/storage_services.dart';

class SocketServices {
  static late io.Socket _socket;
  bool show = false;

  ///<<<============ Connect with socket ====================>>>
  static void connectToSocket() {
    try {
      _socket = io.io(
        ApiEndPoint.socketUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setTimeout(30000) // 30 second timeout
            .build(),
      );

      _socket.onConnect((data) => appLog("=============> Connection $data"));
      _socket.onConnectError((data) {
        appLog("========>Connection Error $data");
        // Don't crash the app on socket connection errors
      });
      _socket.onDisconnect(
        (data) => appLog("========>Socket Disconnected $data"),
      );
      _socket.onError((data) => appLog("========>Socket Error $data"));

      _socket.connect();
      _socket.on("user-notification::${LocalStorage.userId}", (data) {
        appLog("================> get Data on socket: $data");
        NotificationService.showNotification(data);
      });
    } catch (e) {
      appLog("========>Socket Connection Failed: $e");
      // Don't crash the app if socket connection fails
    }
  }

  static on(String event, Function(dynamic data) handler) {
    if (!_socket.connected) {
      connectToSocket();
    }
    _socket.on(event, handler);
  }

  static emit(String event, Function(dynamic data) handler) {
    if (!_socket.connected) {
      connectToSocket();
    }
    _socket.emit(event, handler);
  }

  static emitWithAck(
    String event,
    Map<String, dynamic> data,
    Function(dynamic data) handler,
  ) {
    if (!_socket.connected) {
      connectToSocket();
    }
    _socket.emitWithAck(event, data, ack: handler);
  }
}
