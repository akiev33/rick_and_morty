import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';

import '../../domain/repo/user_repo.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.repo}) : super(InitialState(user: []));

  final UserRepo repo;
  int page = 1;

  Future<void> getInfo() async {
    emit(LoadingState(user: state.user));
    Future.delayed(const Duration(seconds: 1));
    final result = await repo.getInfo(page: page);
    page++;
    if (result.errorText == null) {
      emit(SuccessState(
        user: result.model?.results ?? [],
        info: result.model?.info ?? Info(),
      ));
    } else {
      emit(ErrorState(errorText: result.errorText ?? ''));
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
  SuccessState({required this.user, this.info}) : super(user: user);
}

class ErrorState extends UserState {
  @override
  final List<Results>? user;
  final String errorText;
  ErrorState({required this.errorText, this.user}) : super(user: user);
}
