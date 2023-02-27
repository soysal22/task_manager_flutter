import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final box = GetStorage();
  final key = 'isDarkMode';
  _saveThemeToBox(bool isDarkMode) => box.write(key, isDarkMode);
  bool _loadThemFromBox() => box.read(key) ?? false;

  ThemeMode get theme => _loadThemFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemFromBox());
  }
}
