import 'package:cached_network_image/cached_network_image.dart';
import 'package:conveyance_apps/app/data/theme/theme.dart';
import 'package:conveyance_apps/app/modules/register/views/register_profile_image_view.dart';
import 'package:conveyance_apps/app/shared/widgets/custom_input_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('RegisterView'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.registerKey,
            child: Column(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://img.freepik.com/free-vector/hand-drawn-flat-design-business-communication-concept_52683-77453.jpg",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                CustomTextInput(
                  hintText: 'Full Name',
                  controller: controller.nameCtrl,
                  action: TextInputAction.next,
                ),
                CustomTextInput(
                  hintText: 'Email',
                  controller: controller.emailCtrl,
                  action: TextInputAction.next,
                ),
                Obx(() => CustomTextInput(
                      hintText: 'Password',
                      icon: controller.showPassword.value
                          ? GestureDetector(
                              onTap: () => controller.showPassword.toggle(),
                              child: const Icon(Icons.visibility))
                          : GestureDetector(
                              onTap: () => controller.showPassword.toggle(),
                              child: const Icon(Icons.visibility_off)),
                      controller: controller.passwordCtrl,
                      action: TextInputAction.done,
                      minLength: 8,
                      isHidden: controller.showPassword.value,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  width: Get.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: thirdColor,
                    ),
                    onPressed: () {
                      if (controller.registerKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        Get.to(() => const RegisterProfileImageView());
                      }
                    },
                    child: Text(
                      "Next",
                      style: subtitleText.copyWith(
                          color: whiteColor, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
