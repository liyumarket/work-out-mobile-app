import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/authControllers/login_controller/extensions/handle_error_cases.dart';
import 'package:work_out/helpers/extension/user_info_validator_extension.dart';
import 'package:work_out/service/dio_service.dart';

import '../../../../config/text.dart';
import '../../../../helpers/string_methods.dart';
import '../login_controller.dart';

extension LoginWithAccountExtension on LoginController {
  /// Authenticate with firebase email/password method
  Future<void> loginWithAccount({
    required String email,
    required String password,
  }) async {
    // Check first if they are valid to login directly
    if (password.isValidPassword) {
      try {
        final DioService dioService = DioService();

        dialogsAndLoadingController.showLoading();
        final response = await dioService.postRequest(
          'http://128.140.107.116:4400/api/v1/login/user',
          data: {'password': password, 'phoneNumber': email},
        );

        final user = response.data;
        // no need for popping the loading dialog since if it's working, the auth listener will do its work
      } on FirebaseAuthException catch (e) {
        // on error, first pop the loading dialog
        Get.back();
        handleErrorCases(e);
      }
    }

    //
    if (password.isEmpty) {
      dialogsAndLoadingController.showError(
        capitalize(AppTexts.enterPassword),
      );
    }
    //
    if (!password.isValidPassword) {
      dialogsAndLoadingController.showError(
        capitalize(AppTexts.passwordMustBe5AtLeast),
      );
    }
  }
}
