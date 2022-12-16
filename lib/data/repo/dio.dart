import 'package:dio/dio.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';

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
}
