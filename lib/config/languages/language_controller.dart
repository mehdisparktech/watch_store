import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/storage/storage_services.dart';
import '../../services/storage/storage_keys.dart';

class LanguageController extends GetxController {
  static const String _languageKey = 'selected_language';

  // Available languages
  static const Map<String, Locale> languages = {
    'English': Locale('en', 'US'),
    'Español': Locale('es', 'ES'),
  };

  // Current language
  Rx<Locale> currentLanguage = const Locale('en', 'US').obs;

  // Check if this is first time language selection
  RxBool isFirstTimeLanguageSelection = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
    _checkFirstTimeLanguageSelection();
  }

  // Load saved language from SharedPreferences
  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguageCode = prefs.getString(_languageKey);

      if (savedLanguageCode != null) {
        final locale = _getLocaleFromCode(savedLanguageCode);
        if (locale != null) {
          currentLanguage.value = locale;
          Get.updateLocale(locale);
        }
      }
    } catch (e) {
      // If error loading, keep default language
      print('Error loading saved language: $e');
    }
  }

  // Change language
  Future<void> changeLanguage(String languageName) async {
    final locale = languages[languageName];
    if (locale != null) {
      currentLanguage.value = locale;
      Get.updateLocale(locale);
      await _saveLanguage(locale.toString());
    }
  }

  // Save language to SharedPreferences
  Future<void> _saveLanguage(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
    } catch (e) {
      print('Error saving language: $e');
    }
  }

  // Get locale from language code
  Locale? _getLocaleFromCode(String code) {
    for (final locale in languages.values) {
      if (locale.toString() == code) {
        return locale;
      }
    }
    return null;
  }

  // Get current language name
  String get currentLanguageName {
    for (final entry in languages.entries) {
      if (entry.value == currentLanguage.value) {
        return entry.key;
      }
    }
    return 'English'; // Default
  }

  // Check if current language is English
  bool get isEnglish => currentLanguage.value.languageCode == 'en';

  // Check if current language is Spanish
  bool get isSpanish => currentLanguage.value.languageCode == 'es';

  // Check if this is first time language selection
  Future<void> _checkFirstTimeLanguageSelection() async {
    await LocalStorage.getAllPrefData();
    isFirstTimeLanguageSelection.value = !LocalStorage.languageSelected;
  }

  // Mark language as selected (first time setup completed)
  Future<void> markLanguageAsSelected() async {
    await LocalStorage.setBool(LocalStorageKeys.languageSelected, true);
    LocalStorage.languageSelected = true;
    isFirstTimeLanguageSelection.value = false;
  }

  // Reset language selection (for testing purposes)
  Future<void> resetLanguageSelection() async {
    await LocalStorage.setBool(LocalStorageKeys.languageSelected, false);
    LocalStorage.languageSelected = false;
    isFirstTimeLanguageSelection.value = true;
  }
}
