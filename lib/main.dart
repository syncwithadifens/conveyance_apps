import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NOTE: initialize GetStorage
  await GetStorage.init();
  GetStorage box = GetStorage('authentication');
  // NOTE: initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: box.read('isLogged') != null && box.read('isLogged') == true
          ? Routes.HOME
          : AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
