import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/app_utils.dart';

class SettingController extends GetxController {
  /// Password controller here , use for delete account
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController =
      TextEditingController()..text = LocalStorage.myEmail;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// loading check , use delete account
  bool isLoading = false;

  /// account delete api call here
  deleteAccountRepo() async {
    isLoading = true;
    update();

    var body = {"password": passwordController.text};

    var response = await ApiService.delete(ApiEndPoint.user, body: body);

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.signIn);
    } else {
      Utils.errorSnackBar(response.statusCode, response.message);
    }
    isLoading = false;
    update();
  }

  /// update profile function here
  Future<void> editProfileRepo() async {
    if (!formKey.currentState!.validate()) return;

    if (!LocalStorage.isLogIn) return;
    isLoading = true;
    update();

    Map<String, String> body = {"email": emailController.text};

    var response = await ApiService.patch(
      ApiEndPoint.baseUrl + ApiEndPoint.profile,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = response.data;

      LocalStorage.userId = data['data']?["_id"] ?? "";
      LocalStorage.myImage = data['data']?["profileImage"] ?? "";
      LocalStorage.myName = data['data']?["name"] ?? "";
      LocalStorage.myEmail = data['data']?["email"] ?? "";
      LocalStorage.enterprise = data['data']?["enterprise"] ?? "";
      LocalStorage.setString("userId", LocalStorage.userId);
      LocalStorage.setString("myImage", LocalStorage.myImage);
      LocalStorage.setString("myName", LocalStorage.myName);
      LocalStorage.setString("myEmail", LocalStorage.myEmail);
      LocalStorage.setString("enterprise", LocalStorage.enterprise);
      Utils.successSnackBar("Successfully email Updated", response.message);
      Get.toNamed(AppRoutes.setting);
    } else {
      Utils.errorSnackBar(response.statusCode, response.message);
    }

    isLoading = false;
    update();
  }
}
