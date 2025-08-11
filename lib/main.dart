import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:watch_store/utils/extensions/extension.dart';

import 'app.dart';
import 'config/dependency/dependency_injection.dart';
import 'services/notification/notification_service.dart';
import 'services/socket/socket_service.dart';
import 'services/storage/storage_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Handle Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    // Log the error but don't crash the app for mouse tracker issues
    if (details.exception.toString().contains('mouse_tracker.dart') ||
        details.exception.toString().contains('PointerAddedEvent') ||
        details.exception.toString().contains('PointerRemovedEvent')) {
      // Silently handle mouse tracker errors
      debugPrint('Mouse tracker error handled: ${details.exception}');
      return;
    }
    // For other errors, use default handling
    FlutterError.presentError(details);
  };

  await init.tryCatch();

  runApp(const MyApp());
}

init() async {
  DependencyInjection dI = DependencyInjection();
  dI.dependencies();
  SocketServices.connectToSocket();

  await Future.wait([
    LocalStorage.getAllPrefData(),
    NotificationService.initLocalNotification(),
    dotenv.load(fileName: ".env"),
  ]);
}
