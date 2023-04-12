// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:manger_mission/core/constants/constants.dart';

class Themes {
  static final light = ThemeData(
    backgroundColor: Constants.colorWhite,
    primaryColor: Constants.blusihColor,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
      backgroundColor: Constants.darkGreyColor,
      primaryColor: Constants.darkGreyColor,
      brightness: Brightness.dark);
}

/*  butonla değiştirmek istersek bu foıonksiyonu çağırmamız yeterli 
  onTap: () {
            ThemeService().switchTheme();
 */

/*  
 main dartta da bunu  yapalım ki çalışsın 

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:manger_mission/core/service/theme_services.dart';
import 'package:manger_mission/core/themes/themes.dart';
import 'package:manger_mission/view/home_page.dart';
import 'package:manger_mission/view/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();   // burada bağlanmawsını ve ilk başta kurulmasını sağlıyoruz
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manangment Demo',
      theme: Themes.light,  // buradada değişiklikleri bildiriyoruz
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: const HomePage(),
    );
  }
}
 */
