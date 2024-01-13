import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/providers/firebase_service_provider.dart';

class LoginController extends GetxController {
  final loginKey = GlobalKey<FormState>();
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  var showPassword = true.obs;
  FirebaseServiceProvider firebaseServiceProvider = FirebaseServiceProvider();
  var isLoading = false.obs;
  Future<bool> signIn() async {
    isLoading.value = true;
    final result = await firebaseServiceProvider.signInWithEmail(
        emailCtrl.text, passwordCtrl.text);

    if (result != null) {
      isLoading.value = false;
      return true;
    } else {
      isLoading.value = false;
      return false;
    }
  }
}
