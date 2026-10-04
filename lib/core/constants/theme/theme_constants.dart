import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:moon_design/moon_design.dart';

class ThemeConstants {
  static PageTransitionsTheme pageTransitionsTheme = const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static const BottomNavigationBarThemeData _baseBottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(fontSize: 16),
    unselectedLabelStyle: TextStyle(fontSize: 16),
  );

  static final moonLightToken = MoonTokens.light.copyWith(
    colors: MoonColors.light.copyWith(
      piccolo: AppColor.primaryColor,
      // beerus: ColorConstants.secondaryLight,
    ),
  );

  static AppBarTheme lightAppBar = AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    centerTitle: false,
    // titleTextStyle: MoonTypography.typography.heading.text20,
  );

  static BottomNavigationBarThemeData lightBottomNavigationBarTheme =
      _baseBottomNavigationBarTheme.copyWith(
    backgroundColor: Colors.white,
  );

  static BottomNavigationBarThemeData darkBottomNavigationBarTheme =
      _baseBottomNavigationBarTheme.copyWith();

  /// Dark Token
  static final moonDarkToken = MoonTokens.dark.copyWith(
    colors: MoonColors.dark.copyWith(
      piccolo: AppColor.primaryColor,
      // beerus: ColorConstants.secondaryLight,
    ),
  );

  static AppBarTheme darkAppBar = AppBarTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: MoonColors.dark.gohan,
    centerTitle: false,
    // titleTextStyle: moonDarkToken.typography.heading.text20,
  );
}
