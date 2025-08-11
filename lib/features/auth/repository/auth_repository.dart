import '../data/model/auth_response_model.dart';
import '../data/model/user_model.dart';

abstract class AuthRepository {
  Future<AuthResponseModel> login(LoginRequestModel request);
  Future<AuthResponseModel> register(RegisterRequestModel request);
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
  // final ApiService _apiService;
  // final StorageService _storageService;

  // AuthRepositoryImpl(this._apiService, this._storageService);

  @override
  Future<AuthResponseModel> login(LoginRequestModel request) async {
    try {
      // final response = await _apiService.post('/auth/login', data: request.toJson());
      // return AuthResponseModel.fromJson(response.data);

      // Temporary mock response
      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    try {
      // final response = await _apiService.post('/auth/register', data: request.toJson());
      // return AuthResponseModel.fromJson(response.data);

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<AuthResponseModel> forgotPassword(
    ForgotPasswordRequestModel request,
  ) async {
    try {
      // final response = await _apiService.post('/auth/forgot-password', data: request.toJson());
      // return AuthResponseModel.fromJson(response.data);

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Forgot password failed: $e');
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
    // final token = await getToken();
    // return token != null && token.isNotEmpty;

    throw UnimplementedError('Storage service not implemented yet');
  }

  @override
  Future<String?> getToken() async {
    // return await _storageService.getString('auth_token');

    throw UnimplementedError('Storage service not implemented yet');
  }

  @override
  Future<void> saveToken(String token) async {
    // await _storageService.setString('auth_token', token);

    throw UnimplementedError('Storage service not implemented yet');
  }

  @override
  Future<void> clearToken() async {
    // await _storageService.remove('auth_token');

    throw UnimplementedError('Storage service not implemented yet');
  }
}
