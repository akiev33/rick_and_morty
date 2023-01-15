import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    unselectedWidgetColor: AppColors.color5B6975,
    scaffoldBackgroundColor: AppColors.color0B1E2D,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.color0B1E2D,
    ),
  );
  static final ThemeData lightTheme = ThemeData(
    unselectedWidgetColor: AppColors.color5B6975,
    scaffoldBackgroundColor: AppColors.colorFFFFFF,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.colorFFFFFF,
    ),
  );
}
