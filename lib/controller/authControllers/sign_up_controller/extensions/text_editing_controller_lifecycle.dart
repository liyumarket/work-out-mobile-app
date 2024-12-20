import 'package:flutter/widgets.dart';
import 'package:work_out/controller/authControllers/sign_up_controller/sign_up_controller.dart';

extension TextEditingCtrlLifeCycleExt on SignUpController {
  // This will dispose the text editing controller
  void _disposeTextEditingControllers() {
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpFirstNameController.dispose();
    signUpLastNameController.dispose();
    signUpPhoneController.dispose();
  }

  void _initializeTextEditingControllers() {
    signUpFirstNameController = TextEditingController();
    signUpLastNameController = TextEditingController();
    signUpPhoneController = TextEditingController();

    signUpEmailController = TextEditingController();
    signUpPasswordController = TextEditingController();
  }

  /// this will initialize the text editing controllers
  void Function() get initializeTextEditingControllers =>
      _initializeTextEditingControllers;

  /// this will dispose the text editing controllers
  void Function() get disposeTextEditingControllers =>
      _disposeTextEditingControllers;
}
