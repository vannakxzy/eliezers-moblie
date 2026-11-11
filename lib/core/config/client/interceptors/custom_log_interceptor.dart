
import 'package:dio/dio.dart';

import '../../../utils/log/log_utils.dart';

class CustomLogInterceptor extends Interceptor {
  CustomLogInterceptor();

  final bool enableLogRequestInfo = true;
  final bool enableLogSuccessResponse = true;
  final bool enableLogErrorResponse = true;

  static const bool _enableLogInterceptor = true;

  // Store request start times.
  final Map<RequestOptions, Stopwatch> _stopwatches = {};

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (!_enableLogInterceptor || !enableLogRequestInfo) {
      handler.next(options);
      return;
    }

    final stopwatch = Stopwatch()..start();
    _stopwatches[options] = stopwatch;

    final log = <String>[];

    log.add('========== API REQUEST ==========');
    log.add('Method: ${options.method}');
    log.add('URL: ${options.uri}');
    log.add('Connect Timeout: ${options.connectTimeout}');
    log.add('Send Timeout: ${options.sendTimeout}');
    log.add('Receive Timeout: ${options.receiveTimeout}');

    if (options.data != null) {
      log.add('Request Body:');
      log.add(_prettyResponse(options.data));
    }

    Log.d(log.join('\n'));

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (!_enableLogInterceptor || !enableLogSuccessResponse) {
      handler.next(response);
      return;
    }

    final stopwatch = _stopwatches.remove(
      response.requestOptions,
    );

    stopwatch?.stop();

    final log = <String>[];

    log.add('========== API SUCCESS ==========');
    log.add('Method: ${response.requestOptions.method}');
    log.add('URL: ${response.requestOptions.uri}');
    log.add('Status Code: ${response.statusCode}');
    log.add('Duration: ${stopwatch?.elapsedMilliseconds ?? 0} ms');
    log.add('Response Data:');
    log.add(_prettyResponse(response.data));

    Log.d(log.join('\n'));

    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    final stopwatch = _stopwatches.remove(
      err.requestOptions,
    );

    stopwatch?.stop();

    if (!_enableLogInterceptor || !enableLogErrorResponse) {
      handler.next(err);
      return;
    }

    final log = <String>[];

    log.add('========== API ERROR ==========');
    log.add('Method: ${err.requestOptions.method}');
    log.add('URL: ${err.requestOptions.uri}');
    log.add('Error Type: ${err.type}');
    log.add('Error Message: ${err.message}');
    log.add('Status Code: ${err.response?.statusCode}');
    log.add('Duration: ${stopwatch?.elapsedMilliseconds ?? 0} ms');
    log.add('Response Data:');
    log.add(_prettyResponse(err.response?.data));

    Log.e(log.join('\n'));

    handler.next(err);
  }

  // Safely format data without printing large Base64 strings.
  String _prettyResponse(dynamic data) {
    if (data == null) {
      return 'null';
    }

    if (data is FormData) {
      return _formatFormData(data);
    }

    if (data is Map) {
      final sanitized = _sanitizeMap(data);

      return Log.prettyJson(sanitized);
    }

    if (data is List) {
      if (data.length > 50) {
        return '[Large list omitted: ${data.length} items]';
      }

      return data
          .map((e) {
            if (e is Map) {
              return _sanitizeMap(e);
            }

            return _sanitizeValue(e);
          })
          .toList()
          .toString();
    }

    if (data is String) {
      if (data.length > 1000) {
        return '[Large string omitted: ${data.length} characters]';
      }

      return data;
    }

    return data.toString();
  }

  String _formatFormData(FormData data) {
    final fields = data.fields.map((field) {
      final key = field.key.toLowerCase();

      if (_isSensitiveKey(key)) {
        return '${field.key}: [REDACTED]';
      }

      if (field.value.length > 1000) {
        return '${field.key}: [Large data omitted: ${field.value.length} characters]';
      }

      return '${field.key}: ${field.value}';
    }).join('\n');

    final files = data.files.map((file) {
      return '''
Field: ${file.key}
Filename: ${file.value.filename}
Content Type: ${file.value.contentType}
Length: ${file.value.length} bytes
''';
    }).join('\n');

    return '''
FormData:
Fields:
$fields

Files:
$files
''';
  }

  Map<String, dynamic> _sanitizeMap(Map data) {
    return data.map((key, value) {
      return MapEntry(
        key.toString(),
        _sanitizeValue(value, key: key.toString()),
      );
    });
  }

  dynamic _sanitizeValue(dynamic value, {String key = ''}) {
    final lowerKey = key.toLowerCase();

    if (_isSensitiveKey(lowerKey)) {
      return '[REDACTED]';
    }

    if (_isLargeDataKey(lowerKey)) {
      return '[Large data omitted]';
    }

    if (value is Map) {
      return _sanitizeMap(value);
    }

    if (value is List) {
      if (value.length > 50) {
        return '[Large list omitted: ${value.length} items]';
      }

      return value.map((e) => _sanitizeValue(e)).toList();
    }

    if (value is String && value.length > 1000) {
      return '[Large string omitted: ${value.length} characters]';
    }

    return value;
  }

  bool _isSensitiveKey(String key) {
    return key.contains('token') ||
        key.contains('password') ||
        key.contains('authorization') ||
        key.contains('secret');
  }

  bool _isLargeDataKey(String key) {
    return key.contains('base64') ||
        key.contains('audio') ||
        key.contains('file') ||
        key.contains('image');
  }
}
