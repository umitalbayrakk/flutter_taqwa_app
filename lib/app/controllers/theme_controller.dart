import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/core/themes/app_themes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  Future<void> setTheme(ThemeMode mode) async {
    themeMode.value = mode;
    await _saveTheme(mode);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('themeMode') ?? ThemeMode.system.index;
    themeMode.value = ThemeMode.values[themeIndex];
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
  }
  ThemeData get currentTheme => themeMode.value == ThemeMode.dark ? AppThemes.darkTheme : AppThemes.lightTheme;
}