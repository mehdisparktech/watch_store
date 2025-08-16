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
  try {
    // Initialize dependency injection first
    DependencyInjection dI = DependencyInjection();
    dI.dependencies();

    // Initialize critical services
    await Future.wait([
      LocalStorage.getAllPrefData(),
      NotificationService.initLocalNotification(),
      _loadEnvFile(),
    ]);

    // Initialize socket connection (non-blocking)
    _initializeSocket();
  } catch (e) {
    debugPrint('Initialization error: $e');
    // Continue app execution even if some services fail to initialize
  }
}

void _initializeSocket() {
  try {
    SocketServices.connectToSocket();
  } catch (e) {
    debugPrint('Socket initialization error: $e');
    // Continue without socket connection
  }
}

Future<void> _loadEnvFile() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint('Warning: .env file not found or could not be loaded: $e');
    // Continue without .env file - this is not critical for app functionality
  }
}
