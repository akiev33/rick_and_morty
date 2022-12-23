import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';
import 'package:rick_and_morty/domain/entities/filters_characters_entities.dart';

import '../../domain/repo/user_repo.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.repo}) : super(InitialState(user: []));

  final UserRepo repo;
  List<Results> newUsers = [];
  int currentPage = 1;
  int maxPage = 1;

  Future<void> getInfo({required FilterEntity filterModel}) async {
    if (newUsers.isEmpty) {
      emit(LoadingState(user: state.user));
    }

    if (currentPage <= maxPage) {
      final result = await repo.getInfo(filterEntity: filterModel);
      emit(SuccessState(user: newUsers, isLoading: true));
      if (result.errorText == null) {
        currentPage = filterModel.currentPage ?? 1;
        maxPage = result.model?.info?.pages ?? 1;
        newUsers.addAll(result.model?.results ?? []);
        emit(
          SuccessState(
            user: newUsers,
            info: result.model?.info ?? Info(),
            isLoading: false,
          ),
        );
      } else {
        emit(ErrorState(errorText: result.errorText ?? ''));
      }
    }
  }
}

abstract class UserState {
  final List<Results>? user;
  UserState({required this.user});
}

class InitialState extends UserState {
  @override
  final List<Results>? user;
  InitialState({required this.user}) : super(user: user);
}

class LoadingState extends UserState {
  @override
  final List<Results>? user;
  LoadingState({required this.user}) : super(user: user);
}

class SuccessState extends UserState {
  @override
  final List<Results>? user;
  final Info? info;
  final bool isLoading;
  SuccessState({required this.user, this.info, this.isLoading = false})
      : super(user: user);
}

class ErrorState extends UserState {
  @override
  final List<Results>? user;
  final String errorText;
  ErrorState({required this.errorText, this.user}) : super(user: user);
}
