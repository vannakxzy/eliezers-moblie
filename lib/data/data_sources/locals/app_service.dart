import 'package:flutter/material.dart';

abstract class AppService {
  String get locale;
  ThemeMode get themeMode;

  Future<void> setLocale({
    required String locale,
  });

  Future<void> setThemeMode({
    required ThemeMode themeMode,
  });
}
