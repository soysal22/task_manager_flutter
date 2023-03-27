// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Constants {
// IMAGES
  static const String imageGoogle = "assets/images/google_logo.png";

  static const String imageSplash = "assets/images/splash.png";

// TEXTS

  static const String textCreateAccount = "Create Account";

// Colors
  static const Color colorTransparent = Colors.transparent;
  static const Color colorGrey = Colors.grey;
  static Color? colorGrey100 = Colors.grey[100];
  static Color? colorGrey200 = Colors.grey[200];

  static const Color colorWhite = Colors.white;
  static const Color colorRed = Colors.red;
  static const Color colorBlack = Colors.black;
  static const Color colorYellow = Color.fromARGB(255, 240, 218, 16);

  static const Color blusihColor = Color(0xFF4e5ae8);
  static const Color yellowColor = Color(0xFFFFB746);
  static const Color pinkColor = Color(0xFFff4667);
  static const Color primaryColor = blusihColor;
  static const Color darkGreyColor = Color(0xFF121212);
  static const Color darkHeaderColor = Color(0xFF424242);

  // Padding
  static const EdgeInsets paddingAll10 = EdgeInsets.all(10);
  static const EdgeInsets paddingLeft20 = EdgeInsets.only(left: 20);
// Circular

  static BorderRadius borderRadius10 = BorderRadius.circular(10);
  static BorderRadius borderRadius15 = BorderRadius.circular(15);

  static BorderRadius borderRadius20 = BorderRadius.circular(20);
//Sizedbox

  // Height

  static const SizedBox sizedBoxHeight0 = SizedBox(height: 0);
  static const SizedBox sizedBoxHeight8 = SizedBox(height: 8);
  static const SizedBox sizedBoxHeight10 = SizedBox(height: 10);
  static const SizedBox sizedBoxHeight12 = SizedBox(height: 12);
  static const SizedBox sizedBoxHeight20 = SizedBox(height: 20);

  //   Width

  static const SizedBox sizedBoxWidth4 = SizedBox(width: 4);
  static const SizedBox sizedBoxWidth10 = SizedBox(width: 10);
}
