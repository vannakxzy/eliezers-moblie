import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter_logs/flutter_logs.dart' as logger;

import '../../constants/log_constant.dart';
import 'logger_helper.dart';

mixin LogMixin on Object {
  void logD(String message, {DateTime? time}) {
    Log.d(message, name: runtimeType.toString(), time: time);
  }

  void logE(
    Object? errorMessage, {
    Object? clazz,
    Object? errorObject,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    Log.e(
      errorMessage,
      name: runtimeType.toString(),
      errorObject: errorObject,
      stackTrace: stackTrace,
      time: time,
    );
  }
}

class Log {
  const Log._();

  static const _enableLog = LogConstants.enableGeneralLog;

  static void url(
    Object? message, {
    String? name,
    DateTime? time,
  }) {
    _log('💎 $message', name: name ?? '', time: time);
  }

  static void d(
    Object? message, {
    String? name,
    DateTime? time,
  }) {
    _log('💡 $message', name: name ?? '', time: time);
  }

  static void e(
    Object? errorMessage, {
    String? name,
    Object? errorObject,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _log(
      '💢 $errorMessage',
      name: name ?? '',
      error: errorObject,
      stackTrace: stackTrace,
      time: time,
    );
  }

  static String prettyJson(Map<String, dynamic> json) {
    if (!LogConstants.isPrettyJson) {
      return json.toString();
    }

    final indent = '  ' * 2;
    final encoder = JsonEncoder.withIndent(indent);

    return encoder.convert(json);
  }

  static void _log(
    String message, {
    int level = 0,
    String name = '',
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_enableLog) {
      dev.log(
        message,
        name: name,
        time: time,
        sequenceNumber: sequenceNumber,
        level: level,
        zone: zone,
        error: error,
        stackTrace: stackTrace,
      );
    }

    if (!kDebugMode) {
      // call log record to file

      logger.FlutterLogs.logToFile(
        logFileName: LoggerHelper.myLogFileName,
        overwrite: false,
        logMessage: message,
        appendTimeStamp: true,
      );

      logger.FlutterLogs.logWarn('tag', 'subTag', 'logMessage');
    }
  }
}
