import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _controller = ScrollController(initialScrollOffset: 1);

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
        if (_controller.position.atEdge) {
          bool isTop = _controller.position.pixels == 0;
          if (!isTop) {
            RepositoryProvider.of<UserCubit>(context).getInfo();
          }
        }
      },
    );
  }

  int? countInCharacter;
  bool isChange = true;

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
              CharacterCount(
                countInCharacter: countInCharacter,
                someFunc: (value) {
                  isChange = value;
                  setState(() {});
                },
              ),
              const SizedBox(height: 15),
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
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
                      child: Image.asset(Images.rickNoInternet),
                    );
                  }
                  return Expanded(
                    child: isChange
                        ? ListView.separated(
                            controller: _controller,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      id: state.user?[index].id ?? 0,
                                      idEpisods: [
                                        ...?state.user?[index].episode
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: CharacterModel(state: state.user?[index]),
                            ),
                            itemCount: state.user?.length ?? 0,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                          )
                        : GridView.builder(
                            controller: _controller,
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
                                      idEpisods: [
                                        ...?state.user?[index].episode
                                      ],
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
    );
  }
}
