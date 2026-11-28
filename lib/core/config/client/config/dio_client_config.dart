import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'http_client_config.dart';

@module
abstract class DioClientConfig {
  static const int maxStringLength = 50;

  dynamic _limitLongStrings(dynamic value) {
    if (value is String) {
      if (value.length > maxStringLength) {
        return '${value.substring(0, maxStringLength)}... '
            '[${value.length} characters]';
      }
      return value;
    }

    if (value is Map) {
      return value.map(
        (key, val) => MapEntry(key, _limitLongStrings(val)),
      );
    }

    if (value is List) {
      return value.map(_limitLongStrings).toList();
    }

    return value;
  }

  String _formatData(dynamic data) {
    try {
      final limitedData = _limitLongStrings(data);

      if (limitedData is String) {
        return limitedData;
      }

      return const JsonEncoder.withIndent('  ').convert(limitedData);
    } catch (_) {
      return data.toString();
    }
  }

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
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('========== REQUEST ==========');
          print('${options.method} ${options.uri}');
          print('Headers: ${_formatData(options.headers)}');
          print('Data: ${_formatData(options.data)}');
          print('=============================');

          handler.next(options);
        },
        onResponse: (response, handler) {
          print('========== RESPONSE ==========');
          print('Status: ${response.statusCode}');
          print('URL: ${response.requestOptions.uri}');
          print('Data: ${_formatData(response.data)}');
          print('==============================');

          handler.next(response);
        },
        onError: (error, handler) {
          print('========== ERROR ==========');
          print('URL: ${error.requestOptions.uri}');
          print('Message: ${error.message}');
          print('Response: ${_formatData(error.response?.data)}');
          print('===========================');

          handler.next(error);
        },
      ),
    );

    return dio;
  }

  @lazySingleton
  Dio mainDio(IConfig config) {
    return _createDio(
      baseUrl: config.baseUrl,
      headers: config.headers,
    );
  }

  @lazySingleton
  @Named('bible')
  Dio bibleDio(IConfig config) {
    return _createDio(
      baseUrl: config.bibleUrl,
      headers: config.headers,
    );
  }

  @lazySingleton
  @Named('musicDio')
  Dio musicDio(IConfig config) {
    return _createDio(
      baseUrl: config.musicUrl,
      headers: config.headers,
    );
  }
}
