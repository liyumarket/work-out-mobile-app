import 'package:get/get.dart';

class GetStartedController extends GetxController {

  
// Variables
  bool isTappedDown = false;
  bool isChecked = false;
  late int id;
  bool? previousIsChecked;
  void panDownMethod() {
    isTappedDown = true;
    update();
  }

  void panEndCancel() {
    isTappedDown = false;
    update();
  }

  void toggleIsChecked() {
    previousIsChecked = isChecked;

    isChecked = !isChecked;
    update(
      [id],
      previousIsChecked != isChecked,
    );
  }

}