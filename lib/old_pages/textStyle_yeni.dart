// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/core/constants/constants.dart';

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[400] : Constants.colorGrey,
  ));
}

TextStyle get createHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
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

TextStyle get detailTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
  ));
}


/** ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/core/constants/constants.dart';

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[400] : Constants.colorGrey,
  ));
}

TextStyle get createHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
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

TextStyle get detailTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
  ));
}
 */