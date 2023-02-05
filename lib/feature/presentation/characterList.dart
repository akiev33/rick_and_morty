import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/filters_characters_entities.dart';
import 'package:rick_and_morty/feature/cubit/cubit.dart';
import 'package:rick_and_morty/feature/presentation/characterModel/grid_model.dart';
import 'package:rick_and_morty/feature/presentation/character_count/character_count.dart';
import 'package:rick_and_morty/feature/presentation/detail_screen/detail_screen.dart';
import 'package:rick_and_morty/feature/presentation/error_image/error_search_and_error.dart';
import 'package:rick_and_morty/feature/presentation/search_filter/search.dart';
import '../../theme/app_colors.dart';
import 'characterModel/characterModel.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  final pageScroll = const PageStorageKey<String>('page');
  final filterEntity =
      ValueNotifier<FilterEntity>(FilterEntity(currentPage: 1));
  bool canLoad = true;
  int? countInCharacter;
  bool isChange = true;

  @override
  void dispose() {
    filterEntity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NotificationListener(
        onNotification: (ScrollNotification notif) {
          if (notif.metrics.pixels + 350 > notif.metrics.maxScrollExtent &&
              canLoad) {
            canLoad = false;
            filterEntity.value = filterEntity.value
                .copyWith(currentPage: filterEntity.value.currentPage ?? 1 + 1);
            context.read<UserCubit>().getInfo(
                  filterModel: filterEntity.value,
                );
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
                SearchScreen(
                  onSearch: (name) {
                    filterEntity.value =
                        filterEntity.value.copyWith(searchText: name);
                    BlocProvider.of<UserCubit>(context)
                        .getInfo(filterModel: filterEntity.value);
                  },
                  status: (status, statusId) {
                    log(statusId.toString());
                    filterEntity.value =
                        filterEntity.value.copyWith(status: status);
                    BlocProvider.of<UserCubit>(context)
                        .getInfo(filterModel: filterEntity.value);
                  },
                  gender: (gender, genderId) {
                    log(genderId.toString());
                    filterEntity.value =
                        filterEntity.value.copyWith(gender: gender);
                    BlocProvider.of<UserCubit>(context)
                        .getInfo(filterModel: filterEntity.value);
                  },
                ),
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
                        await Future.delayed(const Duration(milliseconds: 300));
                        canLoad = true;
                      }
                      countInCharacter = state.info?.count ?? 0;
                      setState(() {});
                    }
                  },
                  builder: (context, state) {
                    if (state is ErrorState) {
                      return ErrorImage(error: state.errorText);
                    }
                    if (state is LoadingState) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: AppColors.color43D049,
                          ),
                        ),
                      );
                    }

                    return Expanded(
                      child: isChange
                          ? ListView.separated(
                              key: pageScroll,
                              itemCount: state.user.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        id: state.user[index].id ?? 0,
                                      ),
                                    ),
                                  );
                                },
                                child: CharacterModel(
                                  image: state.user[index].image ?? '',
                                  name: state.user[index].name ?? '',
                                  gender: state.user[index].gender ?? '',
                                  species: state.user[index].species ?? '',
                                  status: state.user[index].status ?? '',
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 20),
                            )
                          : GridView.builder(
                              key: pageScroll,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 25,
                              ),
                              itemCount: state.user.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        id: state.user[index].id ?? 0,
                                      ),
                                    ),
                                  );
                                },
                                child: GridModel(
                                  image: state.user[index].image ?? '',
                                  name: state.user[index].name ?? '',
                                  gender: state.user[index].gender ?? '',
                                  species: state.user[index].species ?? '',
                                  status: state.user[index].status ?? '',
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
