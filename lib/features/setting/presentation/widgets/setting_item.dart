import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/extension/string_extension.dart';
import 'package:moon_design/moon_design.dart';

import '../app_settings.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    this.onTap,
    required this.setting,
    this.trailing,
    this.bottom,
  });

  final GestureTapCallback? onTap;
  final AppSettings setting;
  final Widget? trailing;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return MoonMenuItem(
      borderRadius: context.moonBorders?.interactiveSm,
      // backgroundColor: context.moonColors?.gohan,
      menuItemCrossAxisAlignment: CrossAxisAlignment.center,
      menuItemPadding: EdgeInsets.only(bottom: kPadding, top: kPadding),
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(kPadding / 2),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: context.moonColors!.hit),
        child: Icon(
          setting.icon,
          color: context.moonColors!.piccolo,
        ),
      ),
      label: Padding(
        padding: const EdgeInsets.only(left: kPadding2),
        child: Text(setting.getTitle.firstUpper(),
            style: context.moonTypography!.heading.text16),
      ),
      trailing: trailing ?? Icon(setting.trailing),
    );
  }
}
