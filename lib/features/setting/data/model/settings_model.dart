class AppSettingsModel {
  final String? language;
  final String? theme; // 'light', 'dark', 'system'
  final bool? pushNotifications;
  final bool? emailNotifications;
  final String? currency;
  final String? country;
  final bool? biometricAuth;
  final bool? autoBackup;

  AppSettingsModel({
    this.language,
    this.theme,
    this.pushNotifications,
    this.emailNotifications,
    this.currency,
    this.country,
    this.biometricAuth,
    this.autoBackup,
  });

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      language: json['language']?.toString(),
      theme: json['theme']?.toString(),
      pushNotifications: json['push_notifications'],
      emailNotifications: json['email_notifications'],
      currency: json['currency']?.toString(),
      country: json['country']?.toString(),
      biometricAuth: json['biometric_auth'],
      autoBackup: json['auto_backup'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'theme': theme,
      'push_notifications': pushNotifications,
      'email_notifications': emailNotifications,
      'currency': currency,
      'country': country,
      'biometric_auth': biometricAuth,
      'auto_backup': autoBackup,
    };
  }

  AppSettingsModel copyWith({
    String? language,
    String? theme,
    bool? pushNotifications,
    bool? emailNotifications,
    String? currency,
    String? country,
    bool? biometricAuth,
    bool? autoBackup,
  }) {
    return AppSettingsModel(
      language: language ?? this.language,
      theme: theme ?? this.theme,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      currency: currency ?? this.currency,
      country: country ?? this.country,
      biometricAuth: biometricAuth ?? this.biometricAuth,
      autoBackup: autoBackup ?? this.autoBackup,
    );
  }
}

class PrivacySettingsModel {
  final bool? profileVisibility;
  final bool? activityTracking;
  final bool? dataCollection;
  final bool? personalizedAds;

  PrivacySettingsModel({
    this.profileVisibility,
    this.activityTracking,
    this.dataCollection,
    this.personalizedAds,
  });

  factory PrivacySettingsModel.fromJson(Map<String, dynamic> json) {
    return PrivacySettingsModel(
      profileVisibility: json['profile_visibility'],
      activityTracking: json['activity_tracking'],
      dataCollection: json['data_collection'],
      personalizedAds: json['personalized_ads'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_visibility': profileVisibility,
      'activity_tracking': activityTracking,
      'data_collection': dataCollection,
      'personalized_ads': personalizedAds,
    };
  }

  PrivacySettingsModel copyWith({
    bool? profileVisibility,
    bool? activityTracking,
    bool? dataCollection,
    bool? personalizedAds,
  }) {
    return PrivacySettingsModel(
      profileVisibility: profileVisibility ?? this.profileVisibility,
      activityTracking: activityTracking ?? this.activityTracking,
      dataCollection: dataCollection ?? this.dataCollection,
      personalizedAds: personalizedAds ?? this.personalizedAds,
    );
  }
}

class SecuritySettingsModel {
  final bool? twoFactorAuth;
  final bool? loginAlerts;
  final bool? deviceTracking;
  final List<String>? trustedDevices;

  SecuritySettingsModel({
    this.twoFactorAuth,
    this.loginAlerts,
    this.deviceTracking,
    this.trustedDevices,
  });

  factory SecuritySettingsModel.fromJson(Map<String, dynamic> json) {
    return SecuritySettingsModel(
      twoFactorAuth: json['two_factor_auth'],
      loginAlerts: json['login_alerts'],
      deviceTracking: json['device_tracking'],
      trustedDevices:
          json['trusted_devices'] != null
              ? List<String>.from(
                json['trusted_devices'].map((x) => x.toString()),
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'two_factor_auth': twoFactorAuth,
      'login_alerts': loginAlerts,
      'device_tracking': deviceTracking,
      'trusted_devices': trustedDevices,
    };
  }

  SecuritySettingsModel copyWith({
    bool? twoFactorAuth,
    bool? loginAlerts,
    bool? deviceTracking,
    List<String>? trustedDevices,
  }) {
    return SecuritySettingsModel(
      twoFactorAuth: twoFactorAuth ?? this.twoFactorAuth,
      loginAlerts: loginAlerts ?? this.loginAlerts,
      deviceTracking: deviceTracking ?? this.deviceTracking,
      trustedDevices: trustedDevices ?? this.trustedDevices,
    );
  }
}
