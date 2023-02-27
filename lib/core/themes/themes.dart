import 'package:flutter/material.dart';

const Color blusihColor = Color(0xFF4e5ae8);
const Color yellowColor = Color(0xFFFFB746);
const Color pinkColor = Color(0xFFff4667);
const Color white = Colors.white;
const Color primaryColor = blusihColor;
const Color darkGreyColor = Color(0xFF121212);
const Color darkHeaderColor = Color(0xFF424242);

class Themes {
  static final light =
      ThemeData(primaryColor: primaryColor, brightness: Brightness.light);
  static final dark =
      ThemeData(primaryColor: darkGreyColor, brightness: Brightness.dark);
}
