import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/shared_preference_keys_constants.dart';
import 'app_service.dart';
import 'local_storage_service/local_storage_service.dart';

@LazySingleton(as: AppService)
class AppServiceImpl implements AppService {
  AppServiceImpl({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;
  late final LocalStorageService _localStorageService;

  @override
  ThemeMode get themeMode =>
      _localStorageService.getValue(key: SharedPreferenceKeys.theme)
          as ThemeMode;

  @override
  String get locale =>
      _localStorageService.getString(key: SharedPreferenceKeys.languages) ??
      'km';

  @override
  Future<void> setThemeMode({required ThemeMode themeMode}) async {
    return _localStorageService.setValue(
      key: SharedPreferenceKeys.theme,
      value: themeMode.toString(),
    );
  }

  @override
  Future<void> setLocale({required String locale}) async {
    return _localStorageService.setValue(
      key: SharedPreferenceKeys.languages,
      value: locale,
    );
  }
}
