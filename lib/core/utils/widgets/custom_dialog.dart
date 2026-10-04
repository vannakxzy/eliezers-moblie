import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../constants/constants.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.child,
    this.innerPadding,
    this.outerPadding,
    this.backgroundColor,
  });

  final Widget child;
  final Color? backgroundColor;
  final EdgeInsets? innerPadding;
  final EdgeInsets? outerPadding;

  static final _defaultDialogOuterPadding =
      EdgeInsets.symmetric(horizontal: 40, vertical: 24);

  static final _defaultDialogInnerPadding = EdgeInsets.symmetric(
    horizontal: s3,
    vertical: kPadding2,
  );

  @override
  Widget build(BuildContext context) {
    final outsidePadding = outerPadding ?? _defaultDialogOuterPadding;
    final insidePadding = innerPadding ?? _defaultDialogInnerPadding;
    return Padding(
      padding: outsidePadding,
      child: MoonModal(
        backgroundColor: backgroundColor,
        child: Container(
          width: double.infinity,
          padding: insidePadding,
          child: child,
        ),
      ),
    );
  }
}
