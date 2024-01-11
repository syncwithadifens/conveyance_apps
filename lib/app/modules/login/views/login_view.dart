import 'package:conveyance_apps/app/data/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/custom_input_text.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('LoginView'),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(color: primaryColor),
          child: Form(
            key: controller.loginKey,
            child: Column(
              children: [
                const CustomTextInput(
                  hintText: 'Email',
                ),
                const CustomTextInput(
                  hintText: 'Password',
                  icon: Icon(Icons.visibility),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor,
                  ),
                  onPressed: () {},
                  child: const Text("Login"),
                ),
              ],
            ),
          ),
        ));
  }
}
