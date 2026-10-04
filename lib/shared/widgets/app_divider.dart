import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';

class AppDivider extends Divider {
  const AppDivider({
    super.key,
    super.thickness,
    super.indent = 0,
    super.endIndent = 0,
    super.color = AppColor.primaryColor, // default is now AppColor.primary
  }) : super(height: 0);

  const AppDivider.normal({
    Key? key,
    Color? color,
  }) : this(
          key: key,
          thickness: .2,
          color: color ?? AppColor.primaryColor,
          indent: 0,
          endIndent: 0,
        );

  const AppDivider.small({
    Key? key,
    Color? color,
  }) : this(
          key: key,
          thickness: .2,
          color: color ?? AppColor.primaryColor,
        );

  const AppDivider.medium({
    Key? key,
    Color? color,
  }) : this(
          key: key,
          thickness: .5,
          color: color ?? AppColor.primaryColor,
        );

  const AppDivider.large({
    Key? key,
    Color? color,
  }) : this(
          key: key,
          color: color ?? AppColor.primaryColor,
        );
}
