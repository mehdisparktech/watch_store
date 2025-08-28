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
            .enableReconnection()
            .setReconnectionAttempts(5)
            .setReconnectionDelay(1000)
            .build(),
      );

      _socket.onConnect((data) {
        appLog("=============> Socket Connected: $data");
        // Re-register notification listener on reconnect
        _socket.on("user-notification::${LocalStorage.userId}", (data) {
          appLog("================> get Data on socket: $data");
          NotificationService.showNotification(data);
        });
      });

      _socket.onConnectError((data) {
        appLog("========>Connection Error $data");
        // Don't crash the app on socket connection errors
      });

      _socket.onDisconnect((data) {
        appLog("========>Socket Disconnected $data");
      });

      _socket.onError((data) => appLog("========>Socket Error $data"));

      _socket.connect();
    } catch (e) {
      appLog("========>Socket Connection Failed: $e");
      // Don't crash the app if socket connection fails
    }
  }

  static on(String event, Function(dynamic data) handler) {
    try {
      if (!_socket.connected) {
        connectToSocket();
        // Wait a bit for connection to establish
        Future.delayed(const Duration(milliseconds: 500), () {
          _socket.on(event, handler);
        });
      } else {
        _socket.on(event, handler);
      }
    } catch (e) {
      appLog("========>Socket Event Registration Failed: $e");
    }
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

  /// Check if socket is connected
  static bool get isConnected {
    try {
      return _socket.connected;
    } catch (e) {
      return false;
    }
  }

  /// Disconnect socket
  static void disconnect() {
    try {
      _socket.disconnect();
    } catch (e) {
      appLog("========>Socket Disconnect Error: $e");
    }
  }

  /// Remove specific event listener
  static void off(String event) {
    try {
      _socket.off(event);
    } catch (e) {
      appLog("========>Socket Off Error: $e");
    }
  }

  /// Force reconnect
  static void reconnect() {
    try {
      _socket.disconnect();
      Future.delayed(const Duration(milliseconds: 500), () {
        _socket.connect();
      });
    } catch (e) {
      appLog("========>Socket Reconnect Error: $e");
    }
  }
}
