# Project Structure

## Architecture Pattern
The project follows **Clean Architecture** principles with **Feature-based organization** using GetX for state management.

## Root Directory Structure
```
lib/
├── app.dart                    # Main app configuration
├── main.dart                   # Application entry point
├── component/                  # Reusable UI components
├── config/                     # App configuration
├── features/                   # Feature modules
├── services/                   # Core services
└── utils/                      # Utilities and helpers
```

## Feature Structure
Each feature follows a consistent structure:
```
features/[feature_name]/
├── data/
│   └── model/                  # Data models
├── presentation/
│   ├── controller/             # GetX controllers
│   ├── screen/                 # UI screens
│   └── widgets/                # Feature-specific widgets
└── repository/                 # Data repositories (when needed)
```

## Key Directories

### `/lib/component/`
Reusable UI components organized by type:
- `app_bar/` - Custom app bars
- `bottom_nav_bar/` - Navigation components
- `button/` - Button components
- `image/` - Image widgets
- `text/` - Text components
- `text_field/` - Input components
- `pop_up/` - Modal and popup components
- `screen/` - Screen-level components (error, no internet)
- `other_widgets/` - Miscellaneous widgets

### `/lib/config/`
Application configuration:
- `api/` - API endpoints and configuration
- `dependency/` - Dependency injection setup
- `languages/` - Internationalization
- `route/` - App routing configuration
- `secret_key/` - API keys and secrets
- `theme/` - App theming

### `/lib/services/`
Core application services:
- `api/` - HTTP client and API service
- `location/` - Location services
- `notification/` - Push notification handling
- `responsive/` - Screen responsiveness utilities
- `socket/` - WebSocket/Socket.IO services
- `storage/` - Local storage management

### `/lib/utils/`
Utilities and helpers:
- `constants/` - App constants (colors, strings, styles, icons, images)
- `enum/` - Enumerations
- `extensions/` - Dart extensions
- `helpers/` - Helper functions
- `log/` - Logging utilities

## Naming Conventions
- **Files**: snake_case (e.g., `sign_in_screen.dart`)
- **Classes**: PascalCase (e.g., `SignInController`)
- **Variables/Functions**: camelCase (e.g., `getUserData()`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `API_BASE_URL`)

## Import Organization
1. Flutter/Dart imports first
2. Third-party package imports
3. Local project imports (relative paths)

## Asset Organization
```
assets/
├── images/                     # Image assets
└── icons/                      # Icon assets
```

Assets are referenced in `pubspec.yaml` and accessed via constants in `utils/constants/`.