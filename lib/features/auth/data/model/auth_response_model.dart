import 'user_model.dart';

class AuthResponseModel {
  final bool success;
  final String? message;
  final String? token;
  final String? refreshToken;
  final UserModel? user;
  final String? enterprise;
  AuthResponseModel({
    required this.success,
    this.message,
    this.token,
    this.refreshToken,
    this.user,
    this.enterprise,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] ?? false,
      message: json['message']?.toString(),
      token: json['token']?.toString(),
      refreshToken: json['refresh_token']?.toString(),
      enterprise: json['enterprise']?.toString(),
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'token': token,
      'refresh_token': refreshToken,
      'user': user?.toJson(),
      'enterprise': enterprise,
    };
  }
}

class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class RegisterRequestModel {
  final String name;
  final String email;
  final String password;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password};
  }
}

class VerifyEmailRequestModel {
  final String email;
  final int oneTimeCode;

  VerifyEmailRequestModel({required this.email, required this.oneTimeCode});

  Map<String, dynamic> toJson() {
    return {'email': email, 'oneTimeCode': oneTimeCode};
  }
}

class ChangePasswordRequestModel {
  final String currentPassword;
  final String newPassword;

  ChangePasswordRequestModel({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {'current_password': currentPassword, 'new_password': newPassword};
  }
}

class ForgotPasswordRequestModel {
  final String email;

  ForgotPasswordRequestModel({required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}

class ResetPasswordRequestModel {
  final String newPassword;
  final String confirmPassword;

  ResetPasswordRequestModel({
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {'newPassword': newPassword, 'confirmPassword': confirmPassword};
  }
}
