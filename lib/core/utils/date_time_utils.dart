import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DateTimeUtils {
  DateTimeUtils._();

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);

    return (to.difference(from).inHours / 24).round();
  }

  static int timezoneOffset() {
    return DateTime.now().timeZoneOffset.inHours;
  }

  static DateTime toLocalFromTimestamp({required int utcTimestampMillis}) {
    return DateTime.fromMillisecondsSinceEpoch(utcTimestampMillis, isUtc: true)
        .toLocal();
  }

  static DateTime toUtcFromTimestamp(int localTimestampMillis) {
    return DateTime.fromMillisecondsSinceEpoch(localTimestampMillis,
            isUtc: false)
        .toUtc();
  }

  static DateTime startTimeOfDate() {
    final now = DateTime.now();

    return DateTime(
      now.year,
      now.month,
      now.day,
    );
  }

  static DateTime? toDateTime(String dateTimeString, {bool isUtc = false}) {
    final dateTime = DateTime.tryParse(dateTimeString);
    if (dateTime != null) {
      if (isUtc) {
        return DateTime.utc(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          dateTime.hour,
          dateTime.minute,
          dateTime.second,
          dateTime.millisecond,
          dateTime.microsecond,
        );
      }

      return dateTime;
    }

    return null;
  }

  static DateTime? toNormalizeDateTime(String dateTimeString,
      {bool isUtc = false}) {
    final dateTime = DateTime.tryParse('-123450101 $dateTimeString');
    if (dateTime != null) {
      if (isUtc) {
        return DateTime.utc(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          dateTime.hour,
          dateTime.minute,
          dateTime.second,
          dateTime.millisecond,
          dateTime.microsecond,
        );
      }

      return dateTime;
    }

    return null;
  }

  // static DateTime? tryParse({
  //   String? date,
  //   String? format,
  //   String locale = LocaleConstants.defaultLocale,
  //   bool isUtc = true,
  // }) {
  //   if (date == null) {
  //     return null;
  //   }

  //   if (format == null) {
  //     return DateTime.tryParse(date);
  //   }

  //   final DateFormat dateFormat = DateFormat(format, locale);
  //   try {
  //     return dateFormat.parse(
  //       date,
  //       isUtc,
  //     );
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static DateTime parse({
  //   required String date,
  //   String? format,
  //   String locale = LocaleConstants.defaultLocale,
  //   bool isUtc = true,
  // }) {
  //   if (format == null) {
  //     return DateTime.parse(date);
  //   }

  //   final DateFormat dateFormat = DateFormat(format, locale);
  //   return dateFormat.parse(
  //     date,
  //     isUtc,
  //   );
  // }
}

extension DateTimeExtensions on DateTime {
  String toStringWithFormat(
    String format, {
    String? locale,
  }) {
    return DateFormat(format, locale).format(this);
  }

  DateTime get lastDateOfMonth {
    return DateTime(year, month + 1, 0);
  }

  // String get parseMMMMyyyyToMMyyyy {
  //   String formattedDate =
  //       DateFormat(DateTimeFormatConstants.dateFormatMMyyyy).format(this);
  //   return formattedDate;
  // }

  String get timestamp => '${(millisecondsSinceEpoch ~/ 1000) + 60}';

  int get getGreeting {
    final hour = this.hour;
    if (hour < 12) {
      return 0;
    } else if (hour < 18) {
      return 1;
    } else {
      return 2;
    }
  }

  // String get parseDDMMYYYY {
  //   String formattedDate =
  //       DateFormat(DateTimeFormatConstants.uiDateDmy).format(this);
  //   return formattedDate;
  // }

  int? timeAgo() {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    if (now.day == day && now.month == month && now.year == year) {
      return 0;
    }
    if (day == yesterday.day &&
        month == yesterday.month &&
        year == yesterday.year) {
      return 1;
    }
    var diff = (now.difference(this).inHours / 24).round();
    if (diff < 7) {
      switch (diff) {
        case 1: // monday
          return 2;
        case 2: // tuesday
          return 3;
        case 3: // wednesday
          return 4;
        case 4: // thursday
          return 5;
        case 5: // friday
          return 6;
        case 6: // saturday
          return 7;
        case 7: // sunday
          return 8;
      }
    }
    return null;
  }

  String get toStringYMD {
    return toStringWithFormat('yyyy-MM-dd');
  }

  String get toStringDMY {
    return toStringWithFormat('dd/MM/yyyy');
  }

  String get toStringFull {
    return toStringWithFormat('dd/MM/yyyy - HH:mm:ss');
  }

  String get toStringDMMY {
    return toStringWithFormat('d MMM, yyyy');
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isYesterday {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  bool get isTomorrow {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    return tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year;
  }

  int get displayIndex {
    if (isTomorrow) {
      return 0;
    }
    if (isToday) {
      return 1;
    }
    if (isYesterday) {
      return 2;
    }
    return 3;
  }
}

extension DateTimeTimezoneExtension on DateTime {
  Map<String, tz.Location> get getTimeZoneDatabase {
    tz.initializeTimeZones();

    return tz.timeZoneDatabase.locations;
  }

  int _getESTtoUTCDifference(String locationName) {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation(locationName);
    final tz.TZDateTime nowNY = tz.TZDateTime.now(locationNY);

    return nowNY.timeZoneOffset.inHours;
  }

  DateTime toESTzone(String locationName) {
    DateTime result = toUtc(); // local time to UTC
    result = result.add(Duration(
        hours: _getESTtoUTCDifference(locationName))); // convert UTC to EST

    return result;
  }

  // DateTime fromESTzone(String locationName) {
  //   DateTime result = subtract(Duration(
  //       hours: _getESTtoUTCDifference(locationName))); // convert EST to UTC

  //   String dateTimeAsIso8601String = result.toIso8601String();
  //   dateTimeAsIso8601String +=
  //       dateTimeAsIso8601String.characters.last.equalsIgnoreCase('Z')
  //           ? ''
  //           : 'Z';
  //   result = DateTime.parse(dateTimeAsIso8601String); // make isUtc to be true

  //   result = result.toLocal(); // convert UTC to local time

  //   return result;
  // }
}
