import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/entities_episods.dart';

import '../../domain/repo/user_repo.dart';

class EpisodsCubit extends Cubit<EpisodsState> {
  EpisodsCubit({required this.repo}) : super(EpisodsInitialState());

  final UserRepo repo;

  Future<void> getEpisods() async {
    emit(EpisodsLoadingState());
    final episods = await repo.getEpisods();
    if (episods.errorText == null) {
      emit(
        EpisodsSuccessState(episods: episods.model?.results ?? []),
      );
    } else {
      emit(EpisodsErrorState(errorText: episods.errorText ?? ''));
    }
  }
}

abstract class EpisodsState {}

class EpisodsInitialState extends EpisodsState {}

class EpisodsLoadingState extends EpisodsState {}

class EpisodsSuccessState extends EpisodsState {
  EpisodsSuccessState({required this.episods});
  final List<Results>? episods;
}

class EpisodsErrorState extends EpisodsState {
  EpisodsErrorState({required this.errorText});
  final String? errorText;
}
