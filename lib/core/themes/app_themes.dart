import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    dividerColor: Colors.grey,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    primaryColor: AppColors.blackColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.black, size: 24),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: AppColors.blackColor),
      headlineSmall: TextStyle(color: AppColors.blackColor),
      headlineMedium: TextStyle(color: AppColors.blackColor),
      bodySmall: TextStyle(color: AppColors.blackColor),
      bodyLarge: TextStyle(color: AppColors.blackColor),
      bodyMedium: TextStyle(color: AppColors.blackColor),
      titleLarge: TextStyle(color: AppColors.blackColor),
      titleMedium: TextStyle(color: AppColors.blackColor),
      titleSmall: TextStyle(color: AppColors.blackColor),
    ),
    buttonTheme: const ButtonThemeData(buttonColor: AppColors.darkThemeColor, textTheme: ButtonTextTheme.primary),
    iconTheme: const IconThemeData(color: Colors.black, size: 24),
    colorScheme: ColorScheme.light(primary: AppColors.blackColor, surface: Colors.white, onSurface: Colors.black),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.blackColor,
      hintStyle: TextStyle(color: AppColors.blackColor),
      border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.blackColor)),
      labelStyle: TextStyle(color: AppColors.blackColor),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.blackColor)),
    ),
    cardTheme: CardTheme(color: AppColors.whiteColor),
  );

  static final darkTheme = ThemeData(
    drawerTheme: DrawerThemeData(backgroundColor: AppColors.darkThemeColor),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkThemeColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.dark2ThemeColor,
      foregroundColor: Colors.grey,
      iconTheme: const IconThemeData(color: Colors.white, size: 24),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: AppColors.whiteColor),
      headlineSmall: TextStyle(color: AppColors.whiteColor),
      headlineMedium: TextStyle(color: AppColors.whiteColor),
      bodySmall: TextStyle(color: AppColors.whiteColor),
      bodyLarge: TextStyle(color: AppColors.whiteColor),
      bodyMedium: TextStyle(color: AppColors.whiteColor),
      titleLarge: TextStyle(color: AppColors.whiteColor),
      titleMedium: TextStyle(color: AppColors.whiteColor),
      titleSmall: TextStyle(color: AppColors.whiteColor),
    ),
    iconTheme: const IconThemeData(color: Colors.white, size: 24),
    colorScheme: ColorScheme.dark(
      primary: AppColors.backgroundColor,
      secondary: AppColors.redColor,
      surface: AppColors.whiteColor,
      onSurface: AppColors.blackColor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.blackColor)),
      labelStyle: TextStyle(color: AppColors.blackColor),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.blackColor)),
    ),
    dividerColor: Colors.black,
    cardTheme: CardTheme(color: AppColors.dark2ThemeColor),
  );
}
