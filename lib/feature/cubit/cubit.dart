import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';

import '../../domain/repo/user_repo.dart';
import '../../theme/app_colors.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.repo})
      : super(InitialState(user: null));

  final UserRepo repo;
  int page = 1;

  Future<void> getInfo() async {
    emit(LoadingState(user: state.user));
    Future.delayed(const Duration(seconds: 1));
    final result = await repo.getInfo(page: page);
    page++;
    if (result.errorText == null) {
      emit(SuccessState(user: result.model));
    } else {
      emit(ErrorState(errorText: result.errorText ?? ''));
    }
  }

  

  getColors(int index) {
    if (state.user?.results?[index].status == 'Alive') {
      return AppColors.color43D049;
    }
    if (state.user?.results?[index].status == 'unknown') {
      return AppColors.colorGrey;
    } else {
      return AppColors.colorEB5757;
    }
  }
}

abstract class UserState {
  final UserEntities? user;
  UserState({required this.user});
}

class InitialState extends UserState {
  @override
  final UserEntities? user;
  InitialState({required this.user}) : super(user: user);
}

class LoadingState extends UserState {
  @override
  final UserEntities? user;
  LoadingState({required this.user}) : super(user: user);
}

class SuccessState extends UserState {
  @override
  final UserEntities? user;
  SuccessState({required this.user}) : super(user: user);
}

class ErrorState extends UserState {
  @override
  final UserEntities? user;
  final String errorText;
  ErrorState({required this.errorText, this.user}) : super(user: user);
}
