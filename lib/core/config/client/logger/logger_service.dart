// ignore_for_file: library_private_types_in_public_api

library;

import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'let_log.dart' as ll;

Future<dynamic> initLogSrv({bool? enabled}) async {
  return _LogService.init(enabled: enabled ?? kDebugMode);
}

_LogService get logSrv => _LogService.shared();

class _LogService {
  static _LogService? _sInstance;
  var _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 5,
      errorMethodCount: 3,
      stackTraceBeginIndex: 2,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );
  bool _enabled = false;
  final _httpHash = <String, Stopwatch>{};

  _LogService._();

  factory _LogService.shared() {
    return _sInstance ??= _LogService._();
  }

  static void init({bool enabled = false}) {
    _LogService.shared()._enabled = enabled;
  }

  void log(Object message, [Object? detail]) {
    ll.Logger.log(message, detail);
    if (_enabled) {
      _logger.v(message, error: detail);
    }
  }

  void error(Object message, {Object? detail, StackTrace? stackTrace}) {
    ll.Logger.error(message, detail);
    if (_enabled) {
      dev.log('\x1B[31m'
          '--------------------------------------------------------------------------\n'
          '$message ${detail != null ? '$detail\n' : ''}\n'
          '--------------------------------------------------------------------------\n'
          '\x1B[0m\n');
    }
  }

  void debug(Object message, [Object? detail]) {
    ll.Logger.debug(message, detail);
    if (_enabled) {
      dev.log('$message ${detail != null ? '\n$detail' : ''}');
    }
  }

  void warn(Object message, [Object? detail]) {
    ll.Logger.warn(message, detail);
    if (_enabled) {
      dev.log('\x1B[35m'
          '--------------------------------------------------------------------------\n'
          '$message ${detail != null ? '$detail\n' : ''}\n'
          '--------------------------------------------------------------------------\n'
          '\x1B[0m\n');
    }
  }

  void clear() {
    ll.Logger.clear();
    if (_enabled) {
      _logger.close();
      _logger = Logger();
      _httpHash.clear();
    }
  }

  void net(
    String api, {
    Map<String, String> headers = const {},
    String type = 'Http',
    int status = 100,
    String? data,
  }) {
    ll.Logger.net(api,
        type: type, status: status, data: data, headers: headers);
    if (_enabled) {
      _httpHash['${type}_$api'] = Stopwatch()..start();
      final ls = [
        '--------------------------------------------------------------------------',
        '⬆️ [$status][$type] $api',
        if (data != null) 'Data: $data',
        if (headers.isNotEmpty) ...['Headers: $headers'],
        '--------------------------------------------------------------------------'
      ];
      dev.log('\x1B[36m${ls.join('\n')}\x1B[0m\n');
    }
  }

  void endNet(String api,
      {String type = 'Http', int status = 100, Object? data, Object? headers}) {
    ll.Logger.endNet(api,
        type: type, status: status, data: data, headers: headers);
    if (_enabled) {
      final Stopwatch? stopWatch = _httpHash.remove('${type}_$api');
      if (stopWatch != null) {
        stopWatch.stop();
      }
      dev.log(
        '${(status >= 200 && status < 300) ? '\x1B[32m' : '\x1B[31m'}'
        '--------------------------------------------------------------------------\n'
        '⬇️ [$status][$type] $api\n'
        'Excute Time: ${stopWatch?.elapsedMilliseconds} ms\n'
        'Headers: $headers \n'
        'Rsp: $data\n'
        '--------------------------------------------------------------------------\n'
        '\x1B[0m\n',
      );
    }
  }
}
