import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../gen/i18n/translations.g.dart';

class CustomOffOnSetting extends StatelessWidget {
  final String tilte;
  final String subTitle;
  final bool value;
  final Function(bool) onChanged;
  const CustomOffOnSetting({
    super.key,
    required this.value,
    required this.onChanged,
    required this.tilte,
    this.subTitle = "",
  });

  @override
  Widget build(BuildContext context) {
    return MoonMenuItem(
      menuItemPadding: EdgeInsets.zero,
      onTap: () {},
      borderRadius: context.moonBorders?.interactiveSm,
      verticalGap:
          LocaleSettings.instance.currentLocale == AppLocale.km ? 0 : null,
      trailing: MoonSwitch(
        value: value,
        onChanged: onChanged,
      ),
      label: Text(
        tilte,
        style: context.moonTypography!.body.text18.copyWith(),
      ),
      // content: subTitle != ""
      //     ? Text(
      //         subTitle,
      //         style: context.moonTypography!.body.text16,
      //       )
      //     : null,
    );
  }
}
