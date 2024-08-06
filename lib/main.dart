import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:work_out/bindings/initial_binding.dart';
import 'package:work_out/config/Themes/mainThemeFile.dart';
import 'package:work_out/config/initial_main_methods/initial_main_methods.dart';
import 'package:work_out/service/local_storage_service.dart';
import 'config/routes.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter is initialized before async code
  await MainMethods.init();
  await SharedPreferencesService.getInstance();

  runApp(
    const WorkoutApp(),
  );
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      defaultTransition: Transition.fade,
      theme: MainTheme(context).themeData,
      debugShowCheckedModeBanner: false,
      getPages: Routes.pages,
      initialRoute:
          "/",
    );
  }
}
