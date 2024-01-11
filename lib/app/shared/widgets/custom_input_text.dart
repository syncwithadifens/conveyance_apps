import 'package:flutter/material.dart';

import '../../data/theme/theme.dart';

class CustomTextInput extends StatelessWidget {
  final String hintText;
  final Widget? icon;
  final TextEditingController? controller;
  const CustomTextInput(
      {super.key, required this.hintText, this.icon, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(),
      child: TextFormField(
        controller: controller,
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
          return null;
        },
      ),
    );
  }
}
