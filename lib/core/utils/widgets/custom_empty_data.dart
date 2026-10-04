import 'package:flutter/material.dart';
import '../../../gen/i18n/translations.g.dart';
import 'package:moon_design/moon_design.dart';

class CustomEmptyData extends StatelessWidget {
  const CustomEmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(MoonIcons.generic_bet_32_light,
          //     size: 55, color: context.moonColors!.trunks),
          Text(
            t.common.noData,
            style: context.moonTypography!.body.text16
                .copyWith(color: context.moonColors!.trunks),
          ),
        ],
      ),
    );
  }
}
