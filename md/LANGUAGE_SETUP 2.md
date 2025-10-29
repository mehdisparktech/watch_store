# Language Setup Documentation

This document explains how to use the GetX internationalization system in the Watch Store app.

## Overview

The app supports two languages:

- **English (en_US)** - Default language
- **Spanish (es_ES)** - Secondary language

## Files Structure

```
lib/
├── config/
│   └── languages/
│       ├── language.dart              # Translation keys and values
│       └── language_controller.dart   # Language management controller
├── component/
│   └── other_widgets/
│       └── language_selector.dart     # Language selection widget
├── features/
│   └── setting/
│       └── presentation/
│           └── widgets/
│               └── language_setting_tile.dart  # Settings tile for language
└── utils/
    └── helpers/
        └── translation_helper.dart    # Helper class for translations
```

## How to Use Translations

### 1. Basic Usage

Use `.tr` extension on any string key:

```dart
Text("Sign in".tr)  // Will show "Sign in" in English, "Iniciar sesión" in Spanish
```

### 2. Using Translation Helper

For commonly used translations, use the helper class:

```dart
import '../../utils/helpers/translation_helper.dart';

Text(TranslationHelper.signIn)  // Same as "Sign in".tr
```

### 3. Changing Language

```dart
// Get the language controller
final languageController = Get.find<LanguageController>();

// Change to Spanish
await languageController.changeLanguage('Español');

// Change to English
await languageController.changeLanguage('English');
```

### 4. Check Current Language

```dart
final languageController = Get.find<LanguageController>();

if (languageController.isEnglish) {
  // Do something for English
}

if (languageController.isSpanish) {
  // Do something for Spanish
}
```

## Adding New Translations

1. Open `lib/config/languages/language.dart`
2. Add the new key-value pair to both `en_US` and `es_ES` sections:

```dart
'en_US': {
  // ... existing translations
  "New Key": "English Translation",
},
'es_ES': {
  // ... existing translations
  "New Key": "Traducción en Español",
}
```

3. Use it in your code:

```dart
Text("New Key".tr)
```

## Language Selector Widget

To add language selection to any screen:

```dart
import '../../../component/other_widgets/language_selector.dart';

// In your widget build method:
const LanguageSelector()
```

For settings screen, use the tile widget:

```dart
import '../widgets/language_setting_tile.dart';

// In your settings list:
const LanguageSettingTile()
```

## Current Available Translations

The following keys are currently available:

### Common

- "No Data found"
- "No Internet"
- "Check Internet"
- "Back"
- "Cancel"
- "Done"
- "Yes" / "No"
- "Confirm"
- "Continue"
- "Try Again"

### Authentication

- "Sign in" / "Sign up"
- "Email" / "Password"
- "Full Name"
- "Phone Number"
- "Forgot Password"
- "Create Your Account"
- "Login to Your Account"
- "Already have an account"
- "Don't have an account"
- "Change Password"
- "Current Password"
- "New Password"
- "Confirm Password"

### Profile & Settings

- "Profile"
- "Edit Profile"
- "Settings"
- "Log Out"
- "Privacy Policy"
- "Terms of Services"
- "Delete account"
- "language"

### Messages & Notifications

- "Inbox"
- "Notifications"
- "Message here"
- "Active Now"

## Language Persistence

The selected language is automatically saved to SharedPreferences and will be restored when the app is restarted.

## Testing

To test the language switching:

1. Run the app
2. Go to Settings (if you have the language tile implemented)
3. Tap on Language
4. Select Spanish or English
5. Navigate through the app to see the translations

## Example Implementation

Here's how the sign-up widget was updated to use translations:

**Before:**

```dart
text: AppString.alreadyHaveAccount,
```

**After:**

```dart
text: "Already have an account".tr,
```

The language will automatically switch based on the user's selection.
