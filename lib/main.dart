import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/start_screen.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.color0B1E2D,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.color0B1E2D,
        ),
      ),
      home: const StartScreen(),
    );
  }
}
