import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../../core/extension/string_extension.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';

class ThemeButtonsheet extends StatelessWidget {
  const ThemeButtonsheet._();

  static Future<String> show(BuildContext context) async =>
      await showMoonModalBottomSheet(
        context: context,
        builder: (_) => const ThemeButtonsheet._(),
        // backgroundColor: Colors.transparent,
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum:
          const EdgeInsets.symmetric(horizontal: kPadding, vertical: kPadding2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.logout.description,
            style: context.moonTypography!.body.text14
                .copyWith(color: context.moonColors!.trunks),
          ),
          kPadding2.gap,
          MoonMenuItem(
            horizontalGap: kPadding,
            labelAndContentCrossAxisAlignment: CrossAxisAlignment.center,
            label: Text(
              t.common.confirm.firstUpper(),
              style: context.moonTypography!.body.text14.copyWith(
                  color: AppColor.dangerColor, fontWeight: FontWeight.w500),
            ),
            onTap: () => Navigator.pop(context, true),
          ),
          MoonMenuItem(
            horizontalGap: kPadding,
            labelAndContentCrossAxisAlignment: CrossAxisAlignment.center,
            label: Text(t.common.cancel.firstUpper()),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

enum ImageType { avatar, gallery, camera }
