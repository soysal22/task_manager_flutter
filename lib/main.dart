// ignore_for_file: invalid_return_type_for_catch_error, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/controllers/auth_controller.dart';
import 'package:manger_mission/core/controllers/task_controller.dart';
import 'package:manger_mission/core/service/theme_services.dart';
import 'package:manger_mission/core/themes/themes.dart';
import 'package:manger_mission/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
    Get.put(TaskController());
  });

  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Constants.colorTransparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manangement Demo',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: const SplashScreen(),
    );
  }
}
