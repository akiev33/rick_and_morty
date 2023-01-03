import 'package:flutter/material.dart';
import 'package:rick_and_morty/feature/presentation/buttonNavigationBar/buttonNavigationBar.dart';
import '../../../resources/resources.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ButtonNavigationBar(),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.startScreen),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
