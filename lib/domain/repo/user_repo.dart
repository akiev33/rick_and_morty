import 'package:rick_and_morty/domain/entities/entities.dart';

abstract class UserRepo {
  Future<AppResponse<UserEntities>> getInfo({int page});
}

class AppResponse<T> {
  AppResponse({
    this.errorText,
    this.model,
  });

  final String? errorText;
  final T? model;
}
