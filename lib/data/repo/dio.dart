import 'package:dio/dio.dart';
import 'package:rick_and_morty/domain/entities/entities_detail_character.dart';

import '../../domain/entities/entities.dart';
import '../../domain/entities/entities_episods.dart';
import '../../domain/repo/user_repo.dart';

class InfoDio implements UserRepo {
  InfoDio({required this.dio});

  final Dio dio;

  @override
  Future<AppResponse<UserEntities>> getInfo({int? page}) async {
    try {
      final result = await dio.get('character?page=$page');
      return AppResponse(
        model: UserEntities.fromJson(result.data),
      );
    } catch (e) {
      if (e is DioError) {
        return AppResponse(
          errorText: e.message,
        );
      }
      return AppResponse(
        errorText: e.toString(),
      );
    }
  }

  @override
  Future<AppResponse<Episods>> getEpisods() async {
    try {
      final episods = await dio.get('episode/');
      return AppResponse(
        model: Episods.fromJson(episods.data),
      );
    } catch (e) {
      if (e is DioError) {
        return AppResponse(
          errorText: e.message,
        );
      }
      return AppResponse(
        errorText: e.toString(),
      );
    }
  }

  @override
  Future<AppResponse<DetailCharacter>> getDetailInfo({required int? id}) async {
    try {
      final result = await dio.get('character/$id');
      return AppResponse(
        model: DetailCharacter.fromJson(result.data),
      );
    } catch (e) {
      if (e is DioError) {
        return AppResponse(
          errorText: e.message,
        );
      }
      return AppResponse(
        errorText: e.toString(),
      );
    }
  }
}
