import 'package:get/get.dart';

import '../../../data/providers/firebase_service_provider.dart';

class HomeController extends GetxController {
  FirebaseServiceProvider firebaseServiceProvider = FirebaseServiceProvider();

  Future<void> logOut() async {
    await firebaseServiceProvider.signOut();
  }
}
