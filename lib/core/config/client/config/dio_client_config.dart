import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'http_client_config.dart';

@module
abstract class DioClientConfig {
  // Create Dio with automatic logging
  Dio _createDio({
    required String baseUrl,
    required Map<String, dynamic> headers,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: false,
        // requestHeader: true,
        requestBody: false,
        // responseHeader: true,
        responseBody: false,
        // error: true,
        logPrint: (object) => print('[API LOG] $object'),
      ),
    );

    return dio;
  }

  // Default Main API
  @lazySingleton
  Dio mainDio(IConfig config) {
    return _createDio(
      baseUrl: config.baseUrl,
      headers: config.headers,
    );
  }

  // Bible API
  @lazySingleton
  @Named('bible')
  Dio bibleDio(IConfig config) {
    return _createDio(
      baseUrl: config.bibleUrl,
      headers: config.headers,
    );
  }

  // Music API
  @lazySingleton
  @Named('musicDio')
  Dio musicDio(IConfig config) {
    return _createDio(
      baseUrl: config.musicUrl,
      headers: config.headers,
    );
  }
}
