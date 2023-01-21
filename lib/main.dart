import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/data/network/dio_settings.dart';
import 'package:rick_and_morty/data/repo/dio.dart';
import 'package:rick_and_morty/domain/entities/filters_characters_entities.dart';
import 'package:rick_and_morty/feature/cubit/cubit.dart';
import 'package:rick_and_morty/feature/presentation/start_screen.dart';
import 'package:rick_and_morty/theme/theme.dart';
import 'dart:io';

import 'package:rick_and_morty/theme/theme_provider.dart';

void main() {
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return InitWidget(
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            themeMode: context.watch<ThemeProvider>().themeMode,
            home: const StartScreen(),
          );
        },
      ),
    );
  }
}

class InitWidget extends StatelessWidget {
  const InitWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => DioSettings(),
          ),
          RepositoryProvider(
            create: (context) => InfoDio(
              dio: RepositoryProvider.of<DioSettings>(context).dio,
            ),
          ),
        ],
        child: BlocProvider(
          create: (context) =>
              UserCubit(repo: RepositoryProvider.of<InfoDio>(context))
                ..getInfo(filterModel: FilterEntity()),
          child: child,
        ),
      ),
    );
  }
}
