// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[400] : Constants.colorGrey,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
  ));
}

TextStyle get textHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
  ));
}

TextStyle get inputStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: Constants.colorBlack,
  ));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
  ));
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
  ));
}

TextStyle get buttonTextStyleWhite {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Constants.colorWhite,
  ));
}

TextStyle get buttonTextStyleBlack {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
  ));
}

TextStyle get titleStyleWhite {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Constants.colorWhite,
  ));
}
