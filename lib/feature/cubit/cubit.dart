import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';

import '../../domain/repo/user_repo.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.repo}) : super(InitialState(user: null));

  final UserRepo repo;

  Future<void> getInfo() async {
    emit(LoadingState(user: state.user));
    Future.delayed(const Duration(seconds: 1));
    final result = await repo.getInfo();
    if (result.errorText == null) {
      emit(SuccessState(user: result.model));
    } else {
      emit(ErrorState(errorText: 'Error Text', user: null));
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
  ErrorState({required this.errorText, required this.user}) : super(user: user);
  final String errorText;
  @override
  final UserEntities? user;
}
