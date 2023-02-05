import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/data/repo/dio.dart';
import 'package:rick_and_morty/feature/cubit/cubit_detail_character.dart';
import 'package:rick_and_morty/feature/cubit/cubit_episods.dart';
import 'package:rick_and_morty/feature/presentation/appbar_in_detail/appBar_detail.dart';
import 'package:rick_and_morty/theme/app_colors.dart';
import 'package:rick_and_morty/theme/theme_provider.dart';

import '../../../resources/resources.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) =>
                DetailCharacterCubit(repo: context.read<InfoDio>())
                  ..getDetailInfo(id: id),
          ),
          BlocProvider(
            create: (context) =>
                EpisodsCubit(repo: context.read<InfoDio>())..getEpisods(),
          ),
        ],
        child: BlocBuilder<DetailCharacterCubit, DetailCharacterState>(
          builder: (context, state) {
            if (state is DetailCharacterSuccessState) {
              return CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: AppBarDetail(
                      state: state.detailCharacter,
                      expandedHeight: 230,
                    ),
                    pinned: true,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 115,
                              ),
                              Center(
                                child: Text(
                                  '${state.detailCharacter.name}',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 34,
                                      letterSpacing: 0.25,
                                      color: context
                                          .watch<ThemeProvider>()
                                          .colorInText,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Center(
                                child: Text(
                                  '${state.detailCharacter.status}',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      letterSpacing: 1.5,
                                      color: statusColor(
                                        state.detailCharacter.status ?? '',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Пол',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                            color: AppColors.color5B6975,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        '${state.detailCharacter.gender}',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.25,
                                            color: context
                                                .watch<ThemeProvider>()
                                                .colorInText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 145),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Расса',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                            color: AppColors.color5B6975,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        '${state.detailCharacter.species}',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.25,
                                            color: context
                                                .watch<ThemeProvider>()
                                                .colorInText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 38),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Место рождения',
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.5,
                                        color: AppColors.color5B6975,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    '${state.detailCharacter.origin?.name}',
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.25,
                                        color: context
                                            .watch<ThemeProvider>()
                                            .colorInText,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Местоположение',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                            color: AppColors.color5B6975,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        '${state.detailCharacter.location?.name}',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.25,
                                            color: context
                                                .watch<ThemeProvider>()
                                                .colorInText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 36),
                        Divider(
                          thickness: 2,
                          color: context
                              .watch<ThemeProvider>()
                              .colorDividerHorizontal,
                        ),
                        const SizedBox(height: 36),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Эпизоды',
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        letterSpacing: 0.15,
                                        color: context
                                            .watch<ThemeProvider>()
                                            .colorInText,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Все эпизоды',
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.5,
                                        color: AppColors.color5B6975,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              BlocBuilder<EpisodsCubit, EpisodsState>(
                                builder: (context, state) {
                                  if (state is EpisodsSuccessState) {
                                    return ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        height: 75,
                                        width: double.infinity,
                                        color: context
                                            .watch<ThemeProvider>()
                                            .colorDetailEpisods,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Серия ${state.episods?[index].id}',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.5,
                                                  color: AppColors.color22A2BD
                                                      .withOpacity(0.87),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${state.episods?[index].name}',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  color: context
                                                      .watch<ThemeProvider>()
                                                      .colorInText,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              state.episods?[index].airDate ??
                                                  '',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.25,
                                                  color: AppColors.color6E798C
                                                      .withOpacity(0.60),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 25),
                                      itemCount: state.episods?.length ?? 0,
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            if (state is DetailCharacterErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.ogyr4ikRick,
                      scale: 5,
                    ),
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: AutoSizeText(
                        '$state.errorText',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.colorFFFFFF.withOpacity(0.7),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.color43D049,
              ),
            );
          },
        ),
      ),
    );
  }

  Color statusColor(String text) {
    switch (text) {
      case 'Dead':
        return AppColors.colorEB5757;
      case 'Alive':
        return AppColors.color43D049;
      default:
        return AppColors.colorGrey;
    }
  }
}
