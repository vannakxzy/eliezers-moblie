import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../constants/theme/theme.dart';

@lazySingleton
class ThemeConfig {
  ThemeData get lightTheme => baseLightTheme;
  ThemeData get darkTheme => baseDarkTheme;
}
