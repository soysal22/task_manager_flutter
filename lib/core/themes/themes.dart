import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manger_mission/core/constants/constants.dart';

const Color blusihColor = Color(0xFF4e5ae8);
const Color yellowColor = Color(0xFFFFB746);
const Color pinkColor = Color(0xFFff4667);
const Color white = Colors.white;
const Color primaryColor = blusihColor;
const Color darkGreyColor = Color(0xFF121212);
const Color darkHeaderColor = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
      backgroundColor: white,
      primaryColor: primaryColor,
      brightness: Brightness.light);
  static final dark = ThemeData(
      backgroundColor: darkGreyColor,
      primaryColor: darkGreyColor,
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

TextStyle get subHeadinfgStyle {
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
