import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_store/services/storage/storage_services.dart';
import 'package:watch_store/utils/helpers/other_helper.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/app_utils.dart';

class ProfileController extends GetxController {
  /// Language List here
  List languages = ["English", "French", "Arabic"];

  /// form key here
  final formKey = GlobalKey<FormState>();

  /// select Language here
  String selectedLanguage = "English";

  /// select image here
  String? image;

  /// edit button loading here
  bool isLoading = false;

  /// all controller here
  TextEditingController nameController =
      TextEditingController()..text = LocalStorage.myName;
  TextEditingController numberController = TextEditingController();
  TextEditingController enterprise =
      TextEditingController()..text = LocalStorage.enterprise;

  /// select image function here
  getProfileImage() async {
    image = await OtherHelper.openGalleryForProfile();
    update();
  }

  /// select language  function here
  selectLanguage(int index) {
    selectedLanguage = languages[index];
    update();
    Get.back();
  }

  /// update profile function here
  Future<void> editProfileRepo() async {
    if (!formKey.currentState!.validate()) return;

    if (!LocalStorage.isLogIn) return;
    isLoading = true;
    update();

    Map<String, String> body = {
      "name": nameController.text,
      "enterprise": enterprise.text,
    };

    var response = await ApiService.multipart(
      ApiEndPoint.baseUrl + ApiEndPoint.profile,
      body: body,
      imagePath: image,
      imageName: "profileImage",
      method: "PATCH",
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

      // Clear the selected image after successful update
      image = null;

      Utils.successSnackBar("Successfully Profile Updated", response.message);
      Get.back(); // Go back instead of navigating to edit profile again
    } else {
      Utils.errorSnackBar(response.statusCode, response.message);
    }

    isLoading = false;
    update();
  }

  /// Clear selected image when leaving the screen
  @override
  void onClose() {
    image = null;
    super.onClose();
  }
}
