import 'package:conveyance_apps/app/data/providers/firebase_service_provider.dart';
import 'package:conveyance_apps/app/data/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
          ),
          onPressed: () {
            FirebaseServiceProvider firebaseServiceProvider =
                FirebaseServiceProvider();
            firebaseServiceProvider
                .signOut()
                .then((value) => Get.offNamed(Routes.LOGIN));
          },
          child: Text(
            "Log Out",
            style: TextStyle(color: whiteColor),
          ),
        ),
      ),
    );
  }
}
