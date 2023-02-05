import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/entities_detail_character.dart';

import '../../domain/repo/user_repo.dart';

class DetailCharacterCubit extends Cubit<DetailCharacterState> {
  DetailCharacterCubit({required this.repo})
      : super(DetailCharacterInitialState());

  final UserRepo repo;

  Future<void> getDetailInfo({required int? id}) async {
    emit(DetailCharacterLoadingState());
    final detailModel = await repo.getDetailInfo(id: id);
    if (detailModel.errorText == null) {
      emit(
        DetailCharacterSuccessState(
          detailCharacter: detailModel.model ?? DetailCharacter(),
        ),
      );
    } else {
      emit(DetailCharacterErrorState(errorText: detailModel.errorText ?? ''));
    }
  }
}

abstract class DetailCharacterState {}

class DetailCharacterInitialState extends DetailCharacterState {}

class DetailCharacterLoadingState extends DetailCharacterState {}

class DetailCharacterSuccessState extends DetailCharacterState {
  DetailCharacterSuccessState({required this.detailCharacter});
  final DetailCharacter detailCharacter;
}

class DetailCharacterErrorState extends DetailCharacterState {
  DetailCharacterErrorState({required this.errorText});
  final String? errorText;
}
