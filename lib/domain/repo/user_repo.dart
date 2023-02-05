import 'package:rick_and_morty/domain/entities/entities.dart';
import 'package:rick_and_morty/domain/entities/entities_detail_character.dart';
import 'package:rick_and_morty/domain/entities/filters_characters_entities.dart';

import '../entities/entities_episods.dart';

abstract class UserRepo {
  Future<AppResponse<UserEntities>> getInfo({required FilterEntity filterEntity});
  Future<AppResponse<DetailCharacter>> getDetailInfo({required int? id});
  Future<AppResponse<Episods>> getEpisods();
}

class AppResponse<T> {
  AppResponse({
    this.errorText,
    this.model,
  });

  final String? errorText;
  final T? model;
}
