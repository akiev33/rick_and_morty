import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioSettings {
  DioSettings() {
    setUp();
  }
  late final Dio dio;

  void setUp() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://rickandmortyapi.com/api/',
        sendTimeout: 10000,
        connectTimeout: 10000,
      ),
    );
    dio.interceptors.clear();
    final baseInterceptors = QueuedInterceptorsWrapper(
      onError: (e, handler) {
        handler.next(e);
      },
      onRequest: (options, handler) {
        handler.next(options);
      },
      onResponse: (e, handler) {
        handler.next(e);
      },
    );
    final logInterceptor = LogInterceptor(
      requestBody: true,
      request: true,
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
    );
    dio.interceptors.addAll(
      [
        baseInterceptors,
        if (kDebugMode) logInterceptor,
      ],
    );
  }
}
