import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/data/repo/dio.dart';
import 'package:rick_and_morty/feature/cubit/cubit.dart';
import 'package:rick_and_morty/feature/cubit/cubit_detail_character.dart';
import 'package:rick_and_morty/feature/presentation/appbar_in_detail/appBar_detail.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        lazy: false,
        create: (context) => DetailCharacterCubit(repo: context.read<InfoDio>())
          ..getDetailInfo(id: id),
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
                                      color: AppColors.colorFFFFFF,
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
                                      color:
                                          context.read<UserCubit>().getColors(
                                                state.detailCharacter.id ?? 0,
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
                                            color: AppColors.colorFFFFFF,
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
                                            color: AppColors.colorFFFFFF,
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
                                        color: AppColors.colorFFFFFF,
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
                                            color: AppColors.colorFFFFFF,
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
                          color: AppColors.color152A3A,
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
                                        color: AppColors.colorFFFFFF,
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
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Container(
                                  height: 75,
                                  width: double.infinity,
                                  color: Colors.red,
                                  child: Row(
                                    children: const [
                                      Text(''),
                                    ],
                                  ),
                                ),
                                itemCount: 1,
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
