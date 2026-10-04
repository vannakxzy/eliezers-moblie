import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../gen/fonts.gen.dart';
import 'theme_constants.dart';

final colortext = Colors.black87;

final baseLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: FontFamily.sFPro,
  pageTransitionsTheme: ThemeConstants.pageTransitionsTheme,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: ThemeConstants.lightAppBar.copyWith(
    backgroundColor: Colors.white,
    titleTextStyle:
        MoonTypography.typography.heading.text18.copyWith(color: colortext),
    iconTheme: IconThemeData(color: colortext),
  ),
  bottomNavigationBarTheme:
      ThemeConstants.lightBottomNavigationBarTheme.copyWith(
    selectedItemColor: colortext,
    unselectedItemColor: colortext.withOpacity(0.6),
  ),
  iconTheme: IconThemeData(color: colortext),

  // ---------------- MoonTheme extensions ----------------
  extensions: <ThemeExtension<dynamic>>[
    MoonTheme(
      tokens: ThemeConstants.moonLightToken.copyWith(
        // ---------- Colors ----------
        colors: MoonColors.light.copyWith(
          iconPrimary: colortext,
          iconSecondary: colortext.withOpacity(0.6),
          heles: colortext,
          frieza: colortext.withOpacity(0.9),
          popo: Colors.white,
          piccolo: Color.fromARGB(255, 104, 0, 155),
          hit: colortext.withOpacity(0.2),
          jiren: colortext,
          bulma: colortext,
          gohan: Colors.white,
          trunks: colortext.withOpacity(0.8),
          beerus: colortext.withOpacity(0.3),
        ),

        // ---------- Typography ----------
        typography: MoonTypography.typography.copyWith(
            heading: MoonTypography.typography.heading,
            body: MoonTypography.typography.body.copyWith()
            // .apply(fontFamily: FontFamily.sFPro),
            ),

        // ---------- Default container style ----------
      ),
    ),
  ],

  // ---------------- MoonButtonThemeData for all MoonButtons ----------------
).copyWith(
  buttonTheme: ButtonThemeData(
      // backgroundColor: colortext,
      // foregroundColor: Colors.white,
      // disabledBackgroundColor: colortext.withOpacity(0.5),
      // disabledForegroundColor: Colors.white.withOpacity(0.5),
      // borderRadius: BorderRadius.circular(12),
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      // elevation: 2,
      // hoverBackgroundColor: colortext.withOpacity(0.9),
      // pressedBackgroundColor: colortext.withOpacity(0.8),
      // textStyle: MoonTypography.typography.body.text16.copyWith(
      //   color: Colors.white,
      //   height: 1.0,
      //   fontWeight: FontWeight.w600,
      // ),
      ),
);
