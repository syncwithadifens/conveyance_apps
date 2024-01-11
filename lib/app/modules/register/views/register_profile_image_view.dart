import 'dart:io';

import 'package:conveyance_apps/app/data/theme/theme.dart';
import 'package:conveyance_apps/app/modules/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterProfileImageView extends StatelessWidget {
  const RegisterProfileImageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final registerCtrl = Get.find<RegisterController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('RegisterProfileImageView'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Take a minute to upload image\n or you can skip this",
                style: subtitleText,
                textAlign: TextAlign.center,
              ),
            ),
            Obx(() => GestureDetector(
                  onTap: () => registerCtrl.takeImgFromGallery(),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 40, bottom: 60),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(60),
                            image: registerCtrl.selectedImg.value != null
                                ? DecorationImage(
                                    image: FileImage(File(
                                        registerCtrl.selectedImg.value!.path)),
                                    fit: BoxFit.cover)
                                : null),
                        child: registerCtrl.selectedImg.value == null
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 80,
                              )
                            : null,
                      ),
                      Positioned(
                          bottom: 55,
                          right: 5,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.add,
                              color: greenColor,
                              size: 30,
                            ),
                          ))
                    ],
                  ),
                )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              width: Get.width,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: thirdColor,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Submit')));
                  Get.close(2);
                },
                child: Text(
                  "Submit",
                  style: subtitleText.copyWith(
                      color: whiteColor, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ));
  }
}
