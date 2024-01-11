import 'package:conveyance_apps/app/data/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterProfileImageView extends StatelessWidget {
  const RegisterProfileImageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
            Container(
              margin: const EdgeInsets.only(top: 40, bottom: 60),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(60),
              ),
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
