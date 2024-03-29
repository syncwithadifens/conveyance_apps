import 'package:cached_network_image/cached_network_image.dart';
import 'package:conveyance_apps/app/data/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/widgets/custom_input_text.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          color: primaryColor,
          child: Form(
            key: controller.loginKey,
            child: Column(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://img.freepik.com/free-vector/hand-drawn-flat-design-business-communication-concept_52683-77453.jpg",
                  imageBuilder: (context, imageProvider) => Container(
                    width: Get.width,
                    height: Get.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextInput(
                  controller: controller.emailCtrl,
                  hintText: 'Email',
                  action: TextInputAction.next,
                ),
                Obx(() => CustomTextInput(
                      controller: controller.passwordCtrl,
                      hintText: 'Password',
                      action: TextInputAction.done,
                      icon: controller.showPassword.value
                          ? GestureDetector(
                              onTap: () => controller.showPassword.toggle(),
                              child: const Icon(Icons.visibility))
                          : GestureDetector(
                              onTap: () => controller.showPassword.toggle(),
                              child: const Icon(Icons.visibility_off)),
                      isHidden: controller.showPassword.value,
                    )),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account yet?',
                      style: bodyText,
                      children: [
                        TextSpan(
                            text: ' Sign Up',
                            style: bodyText.copyWith(color: thirdColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(Routes.REGISTER)),
                      ]),
                ),
                Obx(() => Container(
                      height: 50,
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(left: 25, right: 25, top: 30),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                        ),
                        onPressed: () {
                          if (controller.loginKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            controller.signIn().then((value) => value == true
                                ? Get.offNamed(Routes.HOME)
                                : null);
                          }
                        },
                        child: controller.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: thirdColor,
                                ),
                              )
                            : Text(
                                "Sign In",
                                style: titleText.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: thirdColor,
                                    fontSize: 18),
                              ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
