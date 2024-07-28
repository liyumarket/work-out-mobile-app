import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/config/text.dart';
import 'package:work_out/helpers/extension/user_info_validator_extension.dart';
import 'package:work_out/helpers/string_methods.dart';
import 'package:work_out/service/dio_service.dart';
import 'package:work_out/view/screens/homepage/homePage.dart';

import '../../sign_up_controller.dart';

extension CreateNewAccExtension on SignUpController {
  /// create new account in firebase auth, then add the  extra information such as credential, uid, time of creation, email verification status..
  Future<void> createNewAccount({
    required String email,
    required String password,
    required String phone,
    required String firstname,
    required String lastname,
  }) async {
    if (email.isValidEmail && password.isValidPassword) {
      try {
        final DioService dioService = DioService();

        dialogsAndLoadingController.showLoading();
        final response = await dioService.postRequest(
          'http://128.140.107.116:4400/api/v1/signup/USER',
          data: {
            'email': email,
            'password': password,
            'phoneNumber': phone,
            'firstName': firstname,
            'lastName': lastname,
          },
        );

       final user = response.data;
        // // Firebase create account method, store the credential
        // final UserCredential credential =
        //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //   email: email,
        //   password: password,
        // );

        // // Here we created acc with firebase auth, the email and password only,  to collect and use more data, we need to store it
        // addUserInformationToFirestore(
        //   credential: credential,
        //   email: email,
        //   username: username,
        //   isEmailVerified: FirebaseAuth.instance.currentUser!.emailVerified,
        //   uid: credential.user!.uid,
        //   profileImgPath: "",
        //   // password: password,
        // );

        // On sign up, we should verify our user email (no need to unnecessary checks)
        // Get.to(() => EmailVerificatioPage());
       Get.offAll(HomePage());
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

   // Now, if something isn't valid, inform user about it
    if (firstname.isEmpty || email.isEmpty || password.isEmpty) {
      dialogsAndLoadingController.showError(
        capitalize(
          AppTexts.fillFields,
        ),
      );
    } else if (!email.isValidEmail) {
      dialogsAndLoadingController.showError(
        capitalize(
          AppTexts.invalidEmail,
        ),
      );
    } else if (!password.isValidPassword) {
      dialogsAndLoadingController.showError(
        capitalize(
          AppTexts.passwordMustBe5AtLeast,
        ),
      );
    }
  }
}
