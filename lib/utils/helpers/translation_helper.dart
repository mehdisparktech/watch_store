import 'package:get/get.dart';

/// Translation helper class to make it easier to use translations
class TranslationHelper {
  // Common translations
  static String get noDataFound => "No Data found".tr;
  static String get noInternet => "No Internet".tr;
  static String get checkInternet => "Check Internet".tr;
  static String get back => "Back".tr;
  static String get cancel => "Cancel".tr;
  static String get done => "Done".tr;
  static String get yes => "Yes".tr;
  static String get no => "No".tr;
  static String get confirm => "Confirm".tr;
  static String get continueText => "Continue".tr;
  static String get tryAgain => "Try Again".tr;

  // Auth translations
  static String get signIn => "Sign in".tr;
  static String get signUp => "Sign up".tr;
  static String get email => "Email".tr;
  static String get password => "Password".tr;
  static String get fullName => "Full Name".tr;
  static String get phoneNumber => "Phone Number".tr;
  static String get forgotPassword => "Forgot Password".tr;
  static String get createYourAccount => "Create Your Account".tr;
  static String get loginToYourAccount => "Login to Your Account".tr;
  static String get alreadyHaveAccount => "Already have an account".tr;
  static String get doNotHaveAccount => "Don't have an account".tr;
  static String get changePassword => "Change Password".tr;
  static String get currentPassword => "Current Password".tr;
  static String get newPassword => "New Password".tr;
  static String get confirmPassword => "Confirm Password".tr;

  // Profile & Settings
  static String get profile => "Profile".tr;
  static String get editProfile => "Edit Profile".tr;
  static String get settings => "Settings".tr;
  static String get logOut => "Log Out".tr;
  static String get privacyPolicy => "Privacy Policy".tr;
  static String get termsOfServices => "Terms of Services".tr;
  static String get deleteAccount => "Delete account".tr;
  static String get language => "language".tr;

  // Messages & Notifications
  static String get inbox => "Inbox".tr;
  static String get notifications => "Notifications".tr;
  static String get messageHere => "Message here".tr;
  static String get activeNow => "Active Now".tr;

  // Utility method to get translation with fallback
  static String getTranslation(String key, {String? fallback}) {
    final translation = key.tr;
    if (translation == key && fallback != null) {
      return fallback;
    }
    return translation;
  }
}
