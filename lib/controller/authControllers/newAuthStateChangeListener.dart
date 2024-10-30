import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:work_out/service/local_storage_service.dart';
import 'package:work_out/view/screens/auth/EmailVerification.dart';
import 'package:work_out/view/screens/welcome/welcome_page.dart';

import '../../view/screens/homepage/homePage.dart';

class NewAuthStateChangeListener extends GetxController {
  // Instance of the FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // An observable that can bu null
  Rxn<User?> user = Rxn<User?>(null);

  // Auth state handler
  handleTheUserState() {
    if (SharedPreferencesService().getValue(
          'token',
        ) !=
        null) {
      Get.offAll(HomePage());
    } else {
      Get.offAll(WelcomePage());
    }
  }

  @override
  void onReady() {
    handleTheUserState();

    user.bindStream(_auth.authStateChanges());
    super.onReady();
  }
}
