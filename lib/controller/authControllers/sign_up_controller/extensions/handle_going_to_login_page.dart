import 'package:get/get.dart';
import 'package:work_out/controller/authControllers/login_controller/login_controller.dart';

import '../../../../view/screens/auth/login_page.dart';
import '../sign_up_controller.dart';

extension HandleGoingToLoginPageExtension on SignUpController {
  void handleGoingToLoginPage() {
    print(Get.previousRoute);
    Get.put(LoginController());
    Get.previousRoute == "/getStarted" ? Get.to(LoginPage()) : Get.back();
  }
}
