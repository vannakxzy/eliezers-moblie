
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'http_client_config.dart';

@module
abstract class DioClientConfig {
  // Default Main API
  @lazySingleton
  Dio mainDio(IConfig config) {
    return Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        headers: config.headers,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  // Bible API
  @lazySingleton
  @Named('bible')
  Dio bibleDio(IConfig config) {
    return Dio(
      BaseOptions(
        baseUrl: config.bibleUrl,
        headers: config.headers,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  // Music API
  @lazySingleton
  @Named('musicDio')
  Dio musicDio(IConfig config) {
    return Dio(
      BaseOptions(
        baseUrl: config.musicUrl,
        headers: config.headers,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }
}
