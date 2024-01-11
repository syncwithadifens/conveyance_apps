import 'package:flutter/material.dart';

import '../../data/theme/theme.dart';

class CustomTextInput extends StatelessWidget {
  final String hintText;
  final Widget? icon;
  final TextEditingController? controller;
  final TextInputAction? action;
  final int minLength;
  final bool isHidden;
  const CustomTextInput(
      {super.key,
      required this.hintText,
      this.icon,
      this.controller,
      this.action,
      this.minLength = 0,
      this.isHidden = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(),
      child: TextFormField(
        controller: controller,
        textInputAction: action,
        obscureText: isHidden,
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
