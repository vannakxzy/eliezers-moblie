import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'app_colors_constants.dart';

// Material
const EdgeInsets kTextFieldPadding =
    EdgeInsets.symmetric(horizontal: 10, vertical: 10);
const double kAppbarLeadingwidth = 40.0;

const double kButtonHeight = 44.0;
const double kTextTextFieldHeight = 48.0;

const double kBorderWidth = 1.0;
const double kBorderWidthSmall = 0.5;

const double kRadius = 4;
const double kRadius2 = 8;
const double kRadiusMax = 100;

const KDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.25],
    colors: [AppColor.primaryColor, Colors.black],
  ),
);

const double kBottomSheetRadius = 10.0;
const double kCardRadius = 16.0;
const double kPadding = 8.0;
const double kbottomSheetTileHeight = 50.0;
const double kbottomSheetTileTitleHeight = 50.0;

// Screen Padding

const EdgeInsets kScreenPadding =
    EdgeInsets.only(bottom: kPadding, left: kPadding, right: kPadding);

///For Screen Padding
const double kPadding2 = kPadding * 2;
BorderRadius KBorderRadius = BorderRadius.circular(0);
const double s3 = kPadding * 3;
const double s4 = kPadding * 4;
const double s5 = kPadding * 5;
const double s6 = kPadding * 6;

extension Gaping on num {
  Widget get gap => Gap(toDouble());
}

class Space {
  const Space();
  static const kSpace = Gap(kPadding);
  static const p2 = Gap(kPadding2);
  static const p3 = Gap(s3);
  static const p4 = Gap(s4);
  static const p5 = Gap(s5);
  static const p6 = Gap(s6);
}
