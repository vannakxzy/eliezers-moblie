import 'dart:async';
import 'dart:io';

import 'package:flutter_logs/flutter_logs.dart' as logger;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../date_time_utils.dart';

class LoggerHelper {
  static String myLogFileName =
      'RDBLogFile_${DateTime.now().toStringWithFormat('dd-MM-yyyy')}';

  static final Completer _completer = Completer<String>();

  static Future<void> initLogger() async {
    await logger.FlutterLogs.initLogs(
      logLevelsEnabled: [
        logger.LogLevel.INFO,
        logger.LogLevel.WARNING,
        logger.LogLevel.ERROR,
        logger.LogLevel.SEVERE
      ],
      timeStampFormat: logger.TimeStampFormat.TIME_FORMAT_READABLE,
      directoryStructure: logger.DirectoryStructure.FOR_DATE,
      logTypesEnabled: [myLogFileName],
      logFileExtension: logger.LogFileExtension.LOG,
      logsWriteDirectoryName: "SOSMobileLogs",
      logsExportDirectoryName: "SOSMobileLogs/Exported",
      debugFileOperations: true,
      autoDeleteZipOnExport: true,
      logsExportZipFileName: "eliezers_logs",
      isDebuggable: true,
    );

    logger.FlutterLogs.channel.setMethodCallHandler((call) async {
      if (call.method == 'logsExported') {
        // Notify Future with value
        _completer.complete(call.arguments.toString());
      }
    });
  }

  static Future<String> _exportAllLogs() async {
    logger.FlutterLogs.exportLogs();
    return _completer.future as FutureOr<String>;
  }

  static Future<File?> _getLogFile() async {
    final logFilePath = await _exportAllLogs();
    Directory? externalDirectory;

    if (Platform.isIOS) {
      externalDirectory = await getApplicationDocumentsDirectory();
    } else {
      externalDirectory = await getExternalStorageDirectory();
    }

    File file = File("${externalDirectory?.path}/$logFilePath");

    if (file.existsSync()) {
      return file;
    }
    return null;
  }

  static Future<void> shareLogFile() async {
    final file = await _getLogFile();
    if (file != null) {
      await Share.shareXFiles([XFile(file.path)]);
    }
  }

  static Future<void> clearLogs() async {
    return logger.FlutterLogs.clearLogs();
  }
}
