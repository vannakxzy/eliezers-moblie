import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'http_client_config.dart';
import '../interceptors/authorization_interceptor.dart';

import '../interceptors/custom_log_interceptor.dart';

@module
abstract class DioClientConfig {
  @singleton
  Dio dio(IConfig config) {
    Dio dio = Dio()
      ..options.headers = config.headers
      ..options.baseUrl = config.baseUrl
      ..options.sendTimeout = const Duration(seconds: 10)
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      ..interceptors.addAll([
        AuthorizationInterceptor(),
        CustomLogInterceptor(),
      ]);
    return dio;
  }
}
