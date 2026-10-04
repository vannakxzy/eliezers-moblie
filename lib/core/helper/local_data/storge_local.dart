import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/di.dart';

class LocalStorage {
  static SharedPreferences get _prefs => getIt.get<SharedPreferences>();

  static Future<void> storeData({String? key, dynamic value}) async {
    if (value.runtimeType == String) {
      await _prefs.setString(key!, value);
    } else if (value.runtimeType == int) {
      await _prefs.setInt(key!, value);
    } else if (value.runtimeType == bool) {
      await _prefs.setBool(key!, value);
    } else if (value.runtimeType == double) {
      await _prefs.setDouble(key!, value);
    } else {
      _prefs.setStringList(key!, value);
    }
  }

  static int getIntValue(String key) {
    return _prefs.getInt(key) ?? 0;
  }

  static String getStringValue(String key) {
    return _prefs.getString(key) ?? "";
  }

  static bool getBooleanValue(String key) {
    return _prefs.getBool(key) ?? false;
  }

  static double getDoubleValue(String key) {
    return _prefs.getDouble(key) ?? 0.0;
  }

  static List<String> getListString(String key) {
    return _prefs.getStringList(key) ?? [];
  }

  static Future<bool?> remove(String key) {
    return _prefs.remove(key);
  }

  static T? getData<T>(String key,
      {T Function(Map<String, dynamic>)? fromJson}) {
    final Object? value = _prefs.get(key);
    if (value == null) return null;

    // If the value is already of type T, return it
    if (value is T) return value as T;

    // If T is a complex type and fromJson is provided
    if (value is String && fromJson != null) {
      try {
        final Map<String, dynamic> map =
            jsonDecode(value) as Map<String, dynamic>;
        return fromJson(map);
      } catch (e) {
        return null;
      }
    }

    // If we cannot convert, return null or throw error if you want
    return null;
  }
}
