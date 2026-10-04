import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../constants/size_constant.dart';

class CustomButtom extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final bool disable;
  final Color colors;
  final bool outline;
  final MoonButtonSize buttonSize;
  final bool isFullWidth;
  final bool isloading;
  final Widget? trailing;

  const CustomButtom({
    super.key,
    required this.title,
    this.onTap,
    this.isloading = false,
    this.outline = false,
    this.buttonSize = MoonButtonSize.md,
    this.colors = Colors.black,
    this.disable = false,
    this.isFullWidth = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return MoonFilledButton(
      height: 50,
      borderRadius: BorderRadius.circular(15),
      trailing: trailing,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius),
        color: outline
            ? Colors.transparent
            : disable
                ? context.moonColors!.beerus
                : context.moonColors!.piccolo,
        border: Border.all(
            color: outline ? context.moonColors!.piccolo : Colors.transparent,
            width: 0.5),
      ),
      // borderRadius: BorderRadius.circular(kRadius2),
      buttonSize: buttonSize,
      isFullWidth: isFullWidth,
      label: isloading
          ? const MoonCircularLoader(
              sizeValue: 20,
              color: Colors.white,
            )
          : Text(
              title,
              style: context.moonTypography!.body.text16
                  .copyWith(color: Colors.white),
            ),
      onTap: disable == false
          ? () {
              onTap?.call();
            }
          : null,
    );
  }
}
