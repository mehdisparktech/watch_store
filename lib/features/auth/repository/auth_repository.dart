import 'package:watch_store/config/api/api_end_point.dart';
import 'package:watch_store/services/storage/storage_keys.dart';

import '../data/model/auth_response_model.dart';
import '../data/model/user_model.dart';
import '../../../services/api/api_service.dart';
import '../../../services/storage/storage_services.dart';

abstract class AuthRepository {
  Future<AuthResponseModel> login(LoginRequestModel request);
  Future<AuthResponseModel> register(RegisterRequestModel request);
  Future<AuthResponseModel> verifyEmail(VerifyEmailRequestModel request);
  Future<AuthResponseModel> resendOtp(String email); // নতুন মেথড যোগ করা হয়েছে
  Future<AuthResponseModel> forgotPassword(ForgotPasswordRequestModel request);
  Future<AuthResponseModel> changePassword(ChangePasswordRequestModel request);
  Future<AuthResponseModel> refreshToken(String refreshToken);
  Future<UserModel?> getCurrentUser();
  Future<bool> logout();
  Future<bool> isLoggedIn();
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> clearToken();
}

class AuthRepositoryImpl implements AuthRepository {
  final String baseUrl;

  AuthRepositoryImpl({required this.baseUrl});

  @override
  Future<AuthResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await ApiService.post(
        baseUrl + ApiEndPoint.signIn,
        body: request.toJson(),
      );

      if (response.statusCode == 200) {
        final userData = response.data['data']['user'];
        final user = userData != null ? UserModel.fromJson(userData) : null;

        // Debug log to verify enterprise parsing
        print("Parsed enterprise from user: ${user?.enterprise}");

        final authResponse = AuthResponseModel(
          success: response.data['success'] ?? false,
          message: response.data['message'],
          token: response.data['data']['token'],
          enterprise: user?.enterprise, // Get enterprise from user object
          user: user,
        );

        // Save token to storage
        if (authResponse.token != null) {
          await saveToken(authResponse.token!);
        }

        return authResponse;
      } else {
        throw Exception('Login failed: ${response.message}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    try {
      final response = await ApiService.post(
        baseUrl + ApiEndPoint.user,
        body: request.toJson(),
      );

      if (response.statusCode == 200) {
        final authResponse = AuthResponseModel(
          success: response.data['success'] ?? false,
          message: response.data['message'],
          user:
              response.data['data'] != null
                  ? UserModel.fromJson(response.data['data'])
                  : null,
        );

        return authResponse;
      } else {
        throw Exception('Registration failed: ${response.message}');
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<AuthResponseModel> verifyEmail(VerifyEmailRequestModel request) async {
    try {
      final response = await ApiService.post(
        baseUrl + ApiEndPoint.verifyEmail,
        body: request.toJson(),
      );

      if (response.statusCode == 200) {
        final authResponse = AuthResponseModel(
          success: response.data['success'] ?? false,
          message: response.data['message'],
          // No token in verify email response based on API structure
          token: null,
        );

        return authResponse;
      } else {
        throw Exception('Email verification failed: ${response.message}');
      }
    } catch (e) {
      throw Exception('Email verification failed: $e');
    }
  }

  @override
  Future<AuthResponseModel> resendOtp(String email) async {
    try {
      final response = await ApiService.post(
        baseUrl + ApiEndPoint.resendOtp,
        body: {"email": email},
      );

      if (response.statusCode == 200) {
        return AuthResponseModel(
          success: response.data['success'] ?? false,
          message: response.data['message'],
        );
      } else {
        throw Exception('Resend OTP failed: ${response.message}');
      }
    } catch (e) {
      throw Exception('Resend OTP failed: $e');
    }
  }

  @override
  Future<AuthResponseModel> forgotPassword(
    ForgotPasswordRequestModel request,
  ) async {
    try {
      final response = await ApiService.post(
        baseUrl + ApiEndPoint.forgotPassword,
        body: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AuthResponseModel(
          success: response.data['success'] ?? false,
          message: response.data['message'],
        );
      } else {
        throw Exception('Forgot password failed: ${response.message}');
      }
    } catch (e) {
      throw Exception('Forgot password failed: $e');
    }
  }

  Future<AuthResponseModel> verifyEmails(
    VerifyEmailRequestModel request,
  ) async {
    try {
      final response = await ApiService.post(
        baseUrl + ApiEndPoint.verifyEmail,
        body: request.toJson(),
      );

      if (response.statusCode == 200) {
        final authResponse = AuthResponseModel(
          success: response.data['success'] ?? false,
          message: response.data['message'],
          token: response.data['data']['verifyToken'],
        );

        return authResponse;
      } else {
        throw Exception('Email verification failed: ${response.message}');
      }
    } catch (e) {
      throw Exception('Email verification failed: $e');
    }
  }

  Future<AuthResponseModel> resetPassword(
    ResetPasswordRequestModel request,
    String verifyToken,
  ) async {
    try {
      final response = await ApiService.post(
        baseUrl + ApiEndPoint.resetPassword,
        body: request.toJson(),
        header: {"Authorization": "Bearer $verifyToken"},
      );

      if (response.statusCode == 200) {
        return AuthResponseModel(
          success: response.data['success'] ?? false,
          message: response.data['message'],
        );
      } else {
        throw Exception('Reset password failed: ${response.message}');
      }
    } catch (e) {
      throw Exception('Reset password failed: $e');
    }
  }

  @override
  Future<AuthResponseModel> changePassword(
    ChangePasswordRequestModel request,
  ) async {
    try {
      // final response = await _apiService.post('/auth/change-password', data: request.toJson());
      // return AuthResponseModel.fromJson(response.data);

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Change password failed: $e');
    }
  }

  @override
  Future<AuthResponseModel> refreshToken(String refreshToken) async {
    try {
      // final response = await _apiService.post('/auth/refresh', data: {'refresh_token': refreshToken});
      // return AuthResponseModel.fromJson(response.data);

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Token refresh failed: $e');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      // final response = await _apiService.get('/auth/me');
      // return UserModel.fromJson(response.data);

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      // await _apiService.post('/auth/logout');
      // await clearToken();

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getToken() async {
    return LocalStorage.token;
  }

  @override
  Future<void> saveToken(String token) async {
    LocalStorage.token = token;
    await LocalStorage.setString(LocalStorageKeys.token, token);
  }

  @override
  Future<void> clearToken() async {
    LocalStorage.token = "";
    await LocalStorage.setString(LocalStorageKeys.token, "");
  }
}
