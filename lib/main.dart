import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/network/dio_settings.dart';
import 'package:rick_and_morty/data/repo/dio.dart';
import 'package:rick_and_morty/domain/entities/filters_characters_entities.dart';
import 'package:rick_and_morty/feature/cubit/cubit.dart';
import 'package:rick_and_morty/feature/presentation/start_screen.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
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
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.color0B1E2D,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.color0B1E2D,
            ),
          ),
          home: const StartScreen(),
        ),
      ),
    );
  }
}
