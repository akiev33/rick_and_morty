import 'package:flutter/material.dart';
import 'package:rick_and_morty/screens/start_screen/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartScreen(),
    );
  }
}
