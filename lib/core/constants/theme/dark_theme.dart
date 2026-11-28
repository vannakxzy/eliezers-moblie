
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moon_design/moon_design.dart';

import '../../../gen/fonts.gen.dart';
import '../app_colors_constants.dart';
import 'theme_constants.dart';

const Color darkBackground = Color.fromARGB(255, 23, 23, 23);

const SystemUiOverlayStyle darkSystemUiStyle = SystemUiOverlayStyle(
  // Status bar: time, battery, Wi-Fi
  statusBarColor: darkBackground,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,

  // Navigation bar: back, home, recent apps
  systemNavigationBarColor: darkBackground,
  systemNavigationBarIconBrightness: Brightness.light,
  systemNavigationBarDividerColor: darkBackground,
  systemNavigationBarContrastEnforced: false,

  // Android system bar contrast
  systemStatusBarContrastEnforced: false,
);

final baseDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: FontFamily.eBGaramond,

  scaffoldBackgroundColor: darkBackground,
  canvasColor: darkBackground,
  appBarTheme: ThemeConstants.darkAppBar.copyWith(
    backgroundColor: darkBackground,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: darkSystemUiStyle,
    elevation: 0,
  ),

  pageTransitionsTheme: ThemeConstants.pageTransitionsTheme,

  bottomNavigationBarTheme: ThemeConstants.darkBottomNavigationBarTheme,

  extensions: <ThemeExtension<dynamic>>[
    MoonTheme(
      tokens: ThemeConstants.moonDarkToken.copyWith(
        colors: MoonColors.dark.copyWith(
          frieza: const Color.fromARGB(255, 37, 37, 37),
          popo: Colors.white,
          piccolo: AppColor.primaryColor,
          jiren: const Color.fromARGB(255, 237, 62, 50),
          hit: AppColor.primaryColor.withOpacity(0.2),
          gohan: const Color.fromARGB(255, 108, 108, 108),
          trunks: const Color.fromARGB(255, 217, 214, 214),
          beerus: const Color.fromARGB(255, 31, 32, 32),
        ),
        typography: MoonTypography.typography.copyWith(
          heading: MoonTypography.typography.heading.apply(
            fontFamily: FontFamily.eBGaramond,
            fontVariations: [FontVariation.weight(500)],
          ),
          body: MoonTypography.typography.body.apply(
            fontFamily: FontFamily.eBGaramond,
            fontVariations: [FontVariation.weight(400)],
          ),
        ),
      ),
    ),
  ],
);
