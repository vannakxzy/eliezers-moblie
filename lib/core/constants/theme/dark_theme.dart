
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../gen/fonts.gen.dart';
import '../app_colors_constants.dart';
import 'theme_constants.dart';

final baseDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: FontFamily.sFPro,

  scaffoldBackgroundColor: const Color.fromARGB(255, 23, 23, 23),
  // canvasColor: const Color.fromARGB(255, 39, 39, 39),
  // colorScheme: const ColorScheme.dark(
  //   surface: Colors.black,
  // ),

  appBarTheme: ThemeConstants.darkAppBar,
  pageTransitionsTheme: ThemeConstants.pageTransitionsTheme,
  bottomNavigationBarTheme: ThemeConstants.darkBottomNavigationBarTheme,
  extensions: <ThemeExtension<dynamic>>[
    MoonTheme(
      tokens: ThemeConstants.moonDarkToken.copyWith(
        colors: MoonColors.dark.copyWith(
          heles: Colors.black,
          frieza: const Color.fromARGB(255, 37, 37, 37),
          popo: Colors.white,
          piccolo: AppColor.primaryColor,
          jiren: const Color.fromARGB(255, 237, 62, 50),
          hit: AppColor.primaryColor.withOpacity(0.2),
          bulma: Colors.black,
          gohan: const Color.fromARGB(255, 108, 108, 108),
          trunks: const Color.fromARGB(255, 217, 214, 214),
          beerus: const Color.fromARGB(255, 31, 32, 32),
        ),
        typography: MoonTypography.typography.copyWith(
          heading: MoonTypography.typography.heading.apply(
            fontFamily: FontFamily.sFPro,
            fontVariations: [FontVariation.weight(500)],
          ),
          body: MoonTypography.typography.body.apply(
            fontFamily: FontFamily.sFPro,
            fontVariations: [FontVariation.weight(400)],
          ),
        ),
      ),
    ),
  ],
);
