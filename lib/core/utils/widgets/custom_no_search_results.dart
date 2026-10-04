import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../gen/i18n/translations.g.dart';

class CustomNoSearchResults extends StatelessWidget {
  const CustomNoSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          MoonIcons.generic_search_32_regular,
          color: context.moonColors!.trunks,
          size: 50,
        ),
        Text(
          t.common.noSearchResults,
          style: context.moonTypography!.body.text18
              .copyWith(color: context.moonColors!.trunks),
        ),
      ],
    );
  }
}
