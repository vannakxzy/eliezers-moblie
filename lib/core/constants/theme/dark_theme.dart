import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../gen/fonts.gen.dart';
import '../app_colors_constants.dart';
import 'theme_constants.dart';

final baseDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: FontFamily.sFPro,
  scaffoldBackgroundColor: MoonColors.dark.gohan,
  appBarTheme: ThemeConstants.darkAppBar,
  pageTransitionsTheme: ThemeConstants.pageTransitionsTheme,
  bottomNavigationBarTheme: ThemeConstants.darkBottomNavigationBarTheme,
  extensions: <ThemeExtension<dynamic>>[
    MoonTheme(
      tokens: ThemeConstants.moonDarkToken.copyWith(
        colors: MoonColors.dark.copyWith(
          heles: Colors.black,
          frieza: Color.fromARGB(255, 37, 37, 37),
          popo: Colors.white,
          piccolo: AppColor.primaryColor,
          jiren: const Color.fromARGB(255, 237, 62, 50),
          hit: AppColor.primaryColor.withOpacity(0.2),
          bulma: Colors.white,
          gohan: Color.fromARGB(255, 37, 37, 37),
          trunks: const Color.fromARGB(255, 217, 214, 214),
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
