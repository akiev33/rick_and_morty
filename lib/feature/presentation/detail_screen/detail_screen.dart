import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/feature/cubit/cubit.dart';
import 'package:rick_and_morty/feature/presentation/appbar_in_detail/appBar_detail.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.index, required this.state});

  final int index;
  final UserState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: AppBarDetail(
              index: index,
              state: state,
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
                          '${state.user?.results?[index].name}',
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
                          '${state.user?.results?[index].status}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              letterSpacing: 1.5,
                              color: context.read<UserCubit>().getColors(index),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Главный протагонист мультсериала «Рик и Морти».\nБезумный ученый, чей алкоголизм, безрассудность\nи социопатия заставляют беспокоиться семью его\nдочери.',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            color: AppColors.colorFFFFFF,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                '${state.user?.results?[index].gender}',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                '${state.user?.results?[index].species}',
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
                            '${state.user?.results?[index].origin?.name}',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                'null',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.25,
                                    color: AppColors.colorFFFFFF,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 36),
                              const Divider(
                                height: 5,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
