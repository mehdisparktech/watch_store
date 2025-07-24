# Technology Stack

## Framework & Language
- **Flutter** - Cross-platform mobile framework
- **Dart** - Programming language (SDK ^3.7.2)

## Key Dependencies
- **GetX** (^4.7.2) - State management, routing, and dependency injection
- **Dio** (^5.8.0+1) - HTTP client for API calls
- **Flutter ScreenUtil** (^5.9.3) - Screen adaptation and responsive design
- **Socket.IO Client** (^3.1.2) - Real-time communication
- **Flutter Local Notifications** (^18.0.0) - Push notifications
- **Shared Preferences** (^2.5.3) - Local storage
- **Cached Network Image** (^3.4.1) - Image caching
- **Image Picker/Cropper** - Image handling
- **Google Fonts** (^6.2.1) - Typography
- **Flutter SVG** (^2.2.0) - Vector graphics
- **Flutter DotEnv** (^5.2.1) - Environment configuration

## Build System
Flutter's standard build system with platform-specific configurations for Android (Gradle), iOS (Xcode), and desktop platforms.

## Common Commands

### Development
```bash
# Get dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Run in debug mode
flutter run --debug

# Run in release mode
flutter run --release

# Hot reload (during development)
# Press 'r' in terminal or use IDE hot reload
```

### Building
```bash
# Build APK for Android
flutter build apk

# Build App Bundle for Android
flutter build appbundle

# Build for iOS
flutter build ios

# Build for web
flutter build web

# Build for desktop platforms
flutter build macos
flutter build linux  
flutter build windows
```

### Testing & Analysis
```bash
# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format .

# Check for outdated dependencies
flutter pub outdated
```

## Environment Setup
- Requires `.env` file in project root for configuration
- Uses `flutter_dotenv` for environment variable management