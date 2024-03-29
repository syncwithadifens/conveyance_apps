import 'package:conveyance_apps/app/data/providers/firebase_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  final registerKey = GlobalKey<FormState>();
  var nameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  var selectedImg = Rx<XFile?>(null);
  FirebaseServiceProvider firebaseServiceProvider = FirebaseServiceProvider();
  var showPassword = true.obs;
  var isLoading = false.obs;

  Future<void> takeImgFromGallery() async {
    selectedImg.value =
        await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Future<bool> signUp() async {
    isLoading.value = true;
    final result = await firebaseServiceProvider.signUpWithEmail(
        emailCtrl.text, passwordCtrl.text, nameCtrl.text, selectedImg.value);

    if (result != null) {
      isLoading.value = false;
      return true;
    } else {
      isLoading.value = false;
      return false;
    }
  }
}
