import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/feature/cubit/cubit.dart';
import 'package:rick_and_morty/feature/presentation/buttonNavigationBar/buttonNavigationBar.dart';
import 'package:rick_and_morty/feature/presentation/search_filter/search.dart';
import 'package:rick_and_morty/resources/resources.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

import '../../resources/svgIcons.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  getColors(String text) {
    if (text == 'Alive') {
      return AppColors.color43D049;
    }
    if (text == 'unknown') {
      return AppColors.colorGrey;
    } else {
      return AppColors.colorEB5757;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ButtonNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const SearchScreen(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 24,
                    width: 170,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'ВСЕГО ПЕРСОНАЖЕЙ: 200',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            color: AppColors.color5B6975,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        forCube,
                        height: 26,
                        width: 26,
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: AppColors.color43D049,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 74,
                            width: 74,
                            alignment: Alignment.center,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: Image.network(
                              '${state.user?.results?[index].image}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, object, trace) {
                                return Image.asset(Images.imageError2);
                              },
                            ),
                          ),
                          const SizedBox(width: 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${state.user?.results?[index].status}',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    letterSpacing: 1.5,
                                    color: getColors(
                                        '${state.user?.results?[index].status}'),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${state.user?.results?[index].name}',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    color: AppColors.colorFFFFFF,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${state.user?.results?[index].species}, ${state.user?.results?[index].gender}',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    color: AppColors.color6E798C,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      itemCount: state.user!.results!.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
