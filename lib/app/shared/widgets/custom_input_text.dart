import 'package:conveyance_apps/app/modules/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/theme/theme.dart';

class CustomTextInput extends StatelessWidget {
  final String hintText;
  final Widget? icon;
  final TextEditingController? controller;
  final TextInputAction? action;
  final int minLength;
  const CustomTextInput({
    super.key,
    required this.hintText,
    this.icon,
    this.controller,
    this.action,
    this.minLength = 0,
  });

  @override
  Widget build(BuildContext context) {
    final registerCtrl = Get.find<RegisterController>();
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(),
      child: TextFormField(
        controller: controller,
        textInputAction: action,
        obscureText: registerCtrl.showPassword.value,
        decoration: InputDecoration(
            filled: true,
            fillColor: whiteColor,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: icon),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          if (value.length < minLength) {
            return 'Your password less than 8 character';
          }
          return null;
        },
      ),
    );
  }
}
