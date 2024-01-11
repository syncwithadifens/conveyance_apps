import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  final registerKey = GlobalKey<FormState>();
  var nameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  var selectedImg = Rx<XFile?>(null);

  Future<void> takeImgFromGallery() async {
    selectedImg.value =
        await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}
