import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/authControllers/login_controller/extensions/handle_error_cases.dart';
import 'package:work_out/helpers/extension/user_info_validator_extension.dart';
import 'package:work_out/model/user_response.dart';
import 'package:work_out/service/dio_service.dart';
import 'package:work_out/service/local_storage_service.dart';
import 'package:work_out/view/screens/homepage/homePage.dart';

import '../../../../config/text.dart';
import '../../../../helpers/string_methods.dart';
import '../../../../view/screens/homepage/homePage.dart';
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

        final user = UserResponse.fromJson(response.data);
        SharedPreferencesService().setValue('token', user.message?.token);

        Get.offAll(() => HomePage());

        // no need for popping the loading dialog since if it's working, the auth listener will do its work
      } on DioException catch (e) {
        debugPrint(e.toString());
        dialogsAndLoadingController.showError(
          capitalize(
            e.message ?? "Network error",
          ),
        );
      } on Exception catch (e) {
        debugPrint(e.toString());
        dialogsAndLoadingController.showError(
          capitalize(
            e.toString(),
          ),
        );
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
