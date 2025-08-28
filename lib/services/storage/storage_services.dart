import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/log/app_log.dart';
import 'storage_keys.dart';

class LocalStorage {
  static String token = "";
  static String refreshToken = "";
  static bool isLogIn = false;
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";
  static String enterprise = "";
  static bool languageSelected = false;

  // Create Local Storage Instance
  static SharedPreferences? preferences;

  /// Get SharedPreferences Instance
  static Future<SharedPreferences> _getStorage() async {
    preferences ??= await SharedPreferences.getInstance();
    return preferences!;
  }

  /// Get All Data From SharedPreferences
  static Future<void> getAllPrefData() async {
    final localStorage = await _getStorage();

    token = localStorage.getString(LocalStorageKeys.token) ?? "";
    refreshToken = localStorage.getString(LocalStorageKeys.refreshToken) ?? "";
    isLogIn = localStorage.getBool(LocalStorageKeys.isLogIn) ?? false;
    userId = localStorage.getString(LocalStorageKeys.userId) ?? "";
    myImage = localStorage.getString(LocalStorageKeys.myImage) ?? "";
    myName = localStorage.getString(LocalStorageKeys.myName) ?? "";
    myEmail = localStorage.getString(LocalStorageKeys.myEmail) ?? "";
    enterprise = localStorage.getString(LocalStorageKeys.enterprise) ?? "";
    languageSelected =
        localStorage.getBool(LocalStorageKeys.languageSelected) ?? false;

    appLog(userId, source: "Local Storage");
    print("Loaded enterprise from storage: $enterprise");
  }

  /// Remove All Data From SharedPreferences
  static Future<void> removeAllPrefData() async {
    final localStorage = await _getStorage();
    await localStorage.clear();
    _resetLocalStorageData();
    await getAllPrefData();
  }

  // Reset LocalStorage Data
  static void _resetLocalStorageData() {
    final localStorage = preferences!;
    localStorage.setString(LocalStorageKeys.token, "");
    localStorage.setString(LocalStorageKeys.refreshToken, "");
    localStorage.setString(LocalStorageKeys.userId, "");
    localStorage.setString(LocalStorageKeys.myImage, "");
    localStorage.setString(LocalStorageKeys.myName, "");
    localStorage.setString(LocalStorageKeys.myEmail, "");
    localStorage.setString(LocalStorageKeys.enterprise, "");
    localStorage.setBool(LocalStorageKeys.isLogIn, false);
    localStorage.setBool(LocalStorageKeys.languageSelected, false);
  }

  // Save Data To SharedPreferences
  static Future<void> setString(String key, String value) async {
    final localStorage = await _getStorage();
    await localStorage.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    final localStorage = await _getStorage();
    await localStorage.setBool(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    final localStorage = await _getStorage();
    await localStorage.setInt(key, value);
  }
}
