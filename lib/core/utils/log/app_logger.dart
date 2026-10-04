// import 'dart:developer' as devtools;

import 'package:logging/logging.dart';

extension AppLogger on Object? {
  void log([String name = 'LOG']) {
    Logger(name).log(Level.INFO, toString());
  }

  void logE({String name = 'ERROR', StackTrace? stackTrace}) {
    Logger(name).log(
      Level.WARNING,
      toString(),
      this,
      // stackTrace,
    );
  }
}
