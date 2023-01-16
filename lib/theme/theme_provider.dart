import 'package:flutter/material.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late final SharedPreferences prefs;
  bool darkCheck = true;
  ThemeProvider() {
    init();
  }
  ThemeMode themeMode = ThemeMode.dark;
  Color colorInText = AppColors.colorFFFFFF;
  Color colorInSearch = AppColors.color152A3A;
  Color colorBorderInSearch = AppColors.color000000;
  Color colorDivider = AppColors.colorFFFFFF.withOpacity(0.40);
  Color colorButtonNavigationBar = AppColors.color152A3A;
  Color colorButtonNavigationIcons = AppColors.color43D049;
  Color colorDetailTheme = AppColors.color0B1E2D;
  Color colorDividerHorizontal = AppColors.color152A3A;
  Color colorDetailEpisods = AppColors.color152A3A.withOpacity(0.70);

  void init() async {
    prefs = await SharedPreferences.getInstance();
    darkCheck = prefs.getBool('theme') ?? true;
    changeTheme(isDark: darkCheck);
  }

  changeTheme({required bool isDark}) async {
    if (isDark) {
      themeMode = ThemeMode.dark;
      colorInText = AppColors.colorFFFFFF;
      colorInSearch = AppColors.color152A3A;
      colorBorderInSearch = AppColors.color000000;
      colorDivider = AppColors.colorFFFFFF.withOpacity(0.40);
      colorButtonNavigationBar = AppColors.color152A3A;
      colorButtonNavigationIcons = AppColors.color43D049;
      colorDetailTheme = AppColors.color0B1E2D;
      colorDividerHorizontal = AppColors.color152A3A;
      colorDetailEpisods = AppColors.color152A3A.withOpacity(0.70);
    } else {
      themeMode = ThemeMode.light;
      colorInText = AppColors.color000000;
      colorInSearch = AppColors.colorF2F2F2;
      colorBorderInSearch = AppColors.colorFFFFFF;
      colorDivider = Colors.black;
      colorButtonNavigationBar = AppColors.colorFFFFFF;
      colorButtonNavigationIcons = AppColors.color22A2BD;
      colorDetailTheme = AppColors.colorFFFFFF;
      colorDividerHorizontal = AppColors.colorF2F2F2;
      colorDetailEpisods = AppColors.color000000.withOpacity(0.10);
    }
    notifyListeners();
  }
}
