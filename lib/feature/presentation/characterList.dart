import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/domain/entities/filters_characters_entities.dart';
import 'package:rick_and_morty/feature/cubit/cubit.dart';
import 'package:rick_and_morty/feature/presentation/buttonNavigationBar/buttonNavigationBar.dart';
import 'package:rick_and_morty/feature/presentation/characterModel/grid_model.dart';
import 'package:rick_and_morty/feature/presentation/character_count/character_count.dart';
import 'package:rick_and_morty/feature/presentation/detail_screen/detail_screen.dart';
import 'package:rick_and_morty/feature/presentation/search_filter/search.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

import '../../resources/resources.dart';
import 'characterModel/characterModel.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  late final filterEntity = ValueNotifier<FilterEntity>(
    FilterEntity(currentPage: 1),
  );
  bool canLoad = true;
  int? countInCharacter;
  bool isChange = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ButtonNavigationBar(),
      resizeToAvoidBottomInset: false,
      body: NotificationListener(
        onNotification: (ScrollNotification notif) {
          if (notif.metrics.pixels + 250 > notif.metrics.maxScrollExtent &&
              canLoad) {
            canLoad = false;
            filterEntity.value =
                FilterEntity(currentPage: filterEntity.value.currentPage! + 1);
            context.read<UserCubit>().getInfo(filterModel: filterEntity.value);
          }
          return true;
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const SearchScreen(),
                const SizedBox(height: 10),
                CharacterCount(
                  countInCharacter: countInCharacter,
                  someFunc: (value) {
                    isChange = value;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 15),
                BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) async {
                    if (state is SuccessState) {
                      if (!state.isLoading) {
                        await Future.delayed(const Duration(microseconds: 400));
                        canLoad = true;
                      }
                    }
                    if (state is SuccessState) {
                      countInCharacter = state.info?.count ?? 0;
                      setState(() {});
                    }
                  },
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
                    if (state is ErrorState) {
                      return Center(
                        child: Column(
                          children: [
                            Image.asset(
                              Images.ogyr4ikRick,
                              scale: 5,
                            ),
                            Text(
                              '''- I don't know what happened,\nbut something broke!''',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.colorFFFFFF.withOpacity(0.7),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: isChange
                          ? ListView.separated(
                              // controller: _controller,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        id: state.user?[index].id ?? 0,
                                      ),
                                    ),
                                  );
                                },
                                child:
                                    CharacterModel(state: state.user?[index]),
                              ),
                              itemCount: state.user?.length ?? 0,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 20),
                            )
                          : GridView.builder(
                              // controller: _controller,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 25,
                              ),
                              itemCount: state.user?.length ?? 0,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        id: state.user?[index].id ?? 0,
                                      ),
                                    ),
                                  );
                                },
                                child: GridModel(
                                  state: state.user?[index],
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
