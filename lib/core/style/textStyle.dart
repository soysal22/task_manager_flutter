// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';

TextStyle get subHeadingStyle {
  return TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[400] : Constants.colorGrey,
  );
}

TextStyle get createHeadingStyle {
  return TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
  );
}

TextStyle get headingStyle {
  return TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
  );
}

TextStyle get textHeadingStyle {
  return TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
  );
}

TextStyle get inputStyle {
  return const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: Constants.colorBlack,
  );
}

TextStyle get titleStyle {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
  );
}

TextStyle get subtitleStyle {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
  );
}

TextStyle get buttonTextStyleWhite {
  return const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Constants.colorWhite,
  );
}

TextStyle get buttonTextStyleBlack {
  return TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
  );
}

TextStyle get titleStyleWhite {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Constants.colorWhite,
  );
}

TextStyle get detailTitleStyle {
  return TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
  );
}
