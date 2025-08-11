import '../data/model/profile_model.dart';

abstract class ProfileRepository {
  Future<ProfileModel?> getProfile();
  Future<ProfileModel> updateProfile(UpdateProfileRequestModel request);
  Future<String> uploadProfileImage(String imagePath);
  Future<bool> deleteAccount();
}

class ProfileRepositoryImpl implements ProfileRepository {
  // TODO: Inject API service
  // final ApiService _apiService;
  // ProfileRepositoryImpl(this._apiService);

  @override
  Future<ProfileModel?> getProfile() async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.get('/profile');
      // return ProfileModel.fromJson(response.data['data']);

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  @override
  Future<ProfileModel> updateProfile(UpdateProfileRequestModel request) async {
    try {
      // TODO: Implement API call
      // final response = await _apiService.put('/profile', data: request.toJson());
      // return ProfileModel.fromJson(response.data['data']);

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  @override
  Future<String> uploadProfileImage(String imagePath) async {
    try {
      // TODO: Implement file upload
      // final formData = FormData.fromMap({
      //   'image': await MultipartFile.fromFile(imagePath),
      // });
      // final response = await _apiService.post('/profile/upload-image', data: formData);
      // return response.data['data']['image_url'];

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }

  @override
  Future<bool> deleteAccount() async {
    try {
      // TODO: Implement API call
      // await _apiService.delete('/profile');
      // return true;

      throw UnimplementedError('API service not implemented yet');
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }
}
