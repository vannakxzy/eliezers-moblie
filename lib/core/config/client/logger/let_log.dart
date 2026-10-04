// ignore_for_file: cascade_invocations, library_private_types_in_public_api

// library let_log;

import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum _Type { log, debug, warn, error }

List<String> _printNames = ['😄', '🐛', '❗', '❌', '⬆️', '⬇️'];
List<String> _tabNames = ['[Log]', '[Debug]', '[Warn]', '[Error]'];
// final RegExp _tabReg = RegExp(r'\[|\]');

// String _getTabName(int index) {
//   return _tabNames[index].replaceAll(_tabReg, '');
// }

class _Config {
  /// Whether to display the log in reverse order
  bool reverse = false;

  /// Whether or not to print logs in the ide
  bool printNet = true;

  /// Whether or not to print net logs in the ide
  bool printLog = true;

  /// Maximum number of logs, larger than this number, will be cleaned up, default value 500
  int maxLimit = 500;

  /// Set the names in ide print.
  void setPrintNames({
    String? log,
    String? debug,
    String? warn,
    String? error,
    String? request,
    String? response,
  }) {
    _printNames = [
      log ?? '[Log]',
      debug ?? '[Debug]',
      warn ?? '[Warn]',
      error ?? '[Error]',
      request ?? '[Req]',
      response ?? '[Res]',
    ];
  }

  /// Set the names in the app.
  void setTabNames({
    String? log,
    String? debug,
    String? warn,
    String? error,
    String? request,
    String? response,
  }) {
    _tabNames = [
      log ?? '[Log]',
      debug ?? '[Debug]',
      warn ?? '[Warn]',
      error ?? '[Error]',
    ];
  }
}

class Logger {
  const Logger({
    // super.key,
    this.onSavePressed,
    this.onSaveNetPressed,
  });
  final Function(List<ConsoleLogCache> logs)? onSavePressed;
  final Function(List<NetworkLogCache> netlogs)? onSaveNetPressed;
  // @override
  // Widget build(BuildContext context) {
  //   return DefaultTabController(
  //     length: 2,
  //     child: Scaffold(
  //       appBar: AppBar(
  //         title: const TabBar(
  //           tabs: [
  //             Tab(child: Text('Log')),
  //             Tab(child: Text('Net')),
  //           ],
  //         ),
  //         backgroundColor: Colors.blue,
  //         elevation: 0,
  //       ),
  //       body: TabBarView(
  //         children: [
  //           LogWidget(
  //             onSavePressed: (logs, _) => onSavePressed?.call(logs),
  //           ),
  //           NetWidget(
  //             onSavePressed: (_, nets) => onSaveNetPressed?.call(nets),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  static bool enabled = true;
  static _Config config = _Config();

  ///get all logs
  // ignore: strict_raw_type
  static List getAllLogs() {
    return [ConsoleLogCache.list, NetworkLogCache.list];
  }

  /// Logging
  static void log(Object message, [Object? detail]) {
    if (enabled) {
      ConsoleLogCache.add(_Type.log, message, detail);
    }
  }

  /// Record debug information
  static void debug(Object message, [Object? detail]) {
    if (enabled) {
      ConsoleLogCache.add(_Type.debug, message, detail);
    }
  }

  /// Record warnning information
  static void warn(Object message, [Object? detail]) {
    if (enabled) {
      ConsoleLogCache.add(_Type.warn, message, detail);
    }
  }

  /// Record error information
  static void error(Object message, [Object? detail]) {
    if (enabled) {
      ConsoleLogCache.add(_Type.error, message, detail);
    }
  }

  /// Start recording time
  static void time(Object key) {
    if (enabled) {
      ConsoleLogCache.time(key);
    }
  }

  /// End of record time
  static void endTime(Object key) {
    if (enabled) {
      ConsoleLogCache.endTime(key);
    }
  }

  /// Clearance log
  static void clear() {
    ConsoleLogCache.clear();
  }

  /// Recording network information
  static void net(
    String api, {
    String type = 'Http',
    int status = 100,
    Object? data,
    Map<String, String> headers = const {},
  }) {
    if (enabled) {
      NetworkLogCache.request(api, type, status, data, headers);
    }
  }

  /// End of record network information, with statistics on duration and size.
  static void endNet(
    String api, {
    int status = 200,
    Object? data,
    Object? headers,
    String? type,
  }) {
    if (enabled) {
      NetworkLogCache.response(api, status, data, type, headers);
    }
  }

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties
  //       .add(ObjectFlagProperty<Function(List<_Log> logs, List<_Net> netlogs)?>.has('onSavePressed', onSavePressed));
  // }
}

class ConsoleLogCache {
  static final List<ConsoleLogCache> list = [];
  static final ValueNotifier<int> length = ValueNotifier(0);
  static final Map<Object, Object> _map = {};

  final _Type? type;
  final String? message;
  final String? detail;
  final DateTime? start;

  const ConsoleLogCache({this.type, this.message, this.detail, this.start});

  static String capture() {
    return list.getRange(max(0, list.length - 10), list.length).join('\n');
  }

  String get typeName {
    return _printNames[type!.index];
  }

  String get tabName {
    return _tabNames[type!.index];
  }

  bool contains(String keyword) {
    if (keyword.isEmpty) {
      return true;
    }
    return message != null && message!.contains(keyword) ||
        detail != null && detail!.contains(keyword);
  }

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();
    sb.writeln('Message: $message');
    sb.writeln('Time: $start');
    if (detail != null && detail!.length > 100) {
      sb.writeln('Detail: ');
      sb.writeln(detail);
    } else {
      sb.writeln('Detail: $detail');
    }

    return sb.toString();
  }

  static void add(_Type type, Object value, Object? detail) {
    final log = ConsoleLogCache(
      type: type,
      message: value.toString(),
      detail: detail?.toString(),
      start: DateTime.now(),
    );
    list.add(log);
    _clearWhenTooMuch();
    length.value++;
    if (Logger.config.printLog) {
      debugPrint(
        "${log.typeName} ${log.message}${log.detail == null ? '' : '\n${log.detail}'}\n--------------------------------",
      );
    }
  }

  static void _clearWhenTooMuch() {
    if (list.length > Logger.config.maxLimit) {
      list.removeRange(0, (Logger.config.maxLimit * 0.2).ceil());
    }
  }

  static void time(Object key) {
    _map[key] = DateTime.now();
  }

  static void endTime(Object key) {
    final data = _map[key];
    if (data != null) {
      _map.remove(key);
      final spend = DateTime.now().difference(data as DateTime).inMilliseconds;
      ConsoleLogCache.add(_Type.log, '$key: $spend ms', null);
    }
  }

  static void clear() {
    list.clear();
    _map.clear();
    length.value = 0;
  }
}

class NetworkLogCache extends ChangeNotifier {
  static const all = 'All';
  static final List<NetworkLogCache> list = [];
  static final ValueNotifier<int> length = ValueNotifier(0);
  static final Map<String, NetworkLogCache> _map = {};
  static final List<String> types = [all];
  static final ValueNotifier<int> typeLength = ValueNotifier(1);

  final String? api;
  final String? req;
  final DateTime? start;
  String? type;
  int status = 100;
  int spend = 0;
  String? res;
  String headers;
  bool showDetail = false;
  int _reqSize = -1;
  int _resSize = -1;

  NetworkLogCache({
    this.api,
    this.type,
    this.req,
    this.headers = '',
    this.start,
    this.res,
    this.spend = 0,
    this.status = 100,
  });

  static String capture() {
    return list.getRange(max(0, list.length - 10), list.length).join('\n');
  }

  int getReqSize() {
    if (_reqSize > -1) {
      return _reqSize;
    }
    if (req != null && req!.isNotEmpty) {
      try {
        return _reqSize = utf8.encode(req!).length;
      } catch (e) {
        // print(e);
      }
    }
    return 0;
  }

  int getResSize() {
    if (_resSize > -1) {
      return _resSize;
    }
    if (res != null && res!.isNotEmpty) {
      try {
        return _resSize = utf8.encode(res!).length;
      } catch (e) {
        // print(e);
      }
    }
    return 0;
  }

  bool contains(String keyword) {
    if (keyword.isEmpty) {
      return true;
    }
    return api!.contains(keyword) ||
        req != null && req!.contains(keyword) ||
        res != null && res!.contains(keyword);
  }

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();
    sb.writeln('[$status] $api');
    sb.writeln('Start: $start');
    sb.writeln('Spend: $spend ms');
    sb.writeln('Headers: $headers');
    sb.writeln('Request: $req');
    sb.writeln('Response: $res');
    return sb.toString();
  }

  static void request(String api, String type, int status, Object? data,
      Map<String, String> headers) {
    final net = NetworkLogCache(
      api: api,
      type: type,
      status: status,
      req: data?.toString(),
      start: DateTime.now(),
      headers: headers.toString(),
    );
    list.add(net);
    _map[api] = net;
    if (type != '' && !types.contains(type)) {
      types.add(type);
      typeLength.value++;
    }
    _clearWhenTooMuch();
    length.value++;
    if (Logger.config.printNet) {
      debugPrint(
        "${_printNames[4]} ${'$type: '}${net.api}${net.req == null ? '' : '\nData: ${net.req}'}\n--------------------------------",
      );
    }
  }

  static void _clearWhenTooMuch() {
    if (list.length > Logger.config.maxLimit) {
      list.removeRange(0, (Logger.config.maxLimit * 0.2).ceil());
    }
  }

  static void response(
      String api, int status, Object? data, String? type, Object? headers) {
    NetworkLogCache? net = _map[api];
    if (net != null) {
      // ignore: collection_methods_unrelated_type
      _map.remove(net);
      net.spend = DateTime.now().difference(net.start!).inMilliseconds;
      net.headers = headers.toString();
      net.status = status;
      // net.headers = headers.toString();
      net.res = data?.toString();
      length.notifyListeners();
    } else {
      net = NetworkLogCache(
        api: api,
        start: DateTime.now(),
        type: type,
        headers: headers.toString(),
      );
      net.status = status;
      // net.headers = headers.toString();
      net.res = data?.toString();
      list.add(net);
      _clearWhenTooMuch();
      length.value++;
    }
    if (Logger.config.printNet) {
      debugPrint(
        "${_printNames[5]} ${net.type == null ? '' : '${net.type}: '}${net.api}${net.res == null ? '' : '\nSpend: ${net.spend} ms\nData: ${net.res}'}\n--------------------------------",
      );
    }
  }

  static void clear() {
    list.clear();
    _map.clear();
    length.value = 0;
  }
}
