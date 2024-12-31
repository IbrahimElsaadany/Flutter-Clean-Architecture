import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.pruple,
    onPrimary: AppColors.floor,
    secondary: AppColors.black,
    onSecondary: AppColors.floor,
    error: AppColors.red,
    onError: AppColors.floor,
    surface: AppColors.floor,
    onSurface: AppColors.lightPurple,
  ),
  appBarTheme: const AppBarTheme(
    foregroundColor: AppColors.pruple,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.pruple,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.pruple
    )
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: AppColors.pruple),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.pruple
    ),
    titleSmall: TextStyle(
      color: AppColors.pruple
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.bold
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.pruple,
      foregroundColor: Colors.white,
      iconColor: Colors.white,
    )
  )
);