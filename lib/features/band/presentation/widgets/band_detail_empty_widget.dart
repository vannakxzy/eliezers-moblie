import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/constants.dart';
import '../../../../gen/i18n/translations.g.dart';

class bandDetailEmptyWidget extends StatelessWidget {
  const bandDetailEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          kPadding2.gap,
          kPadding2.gap,
          kPadding2.gap,
          Container(
            height: 1,
            width: double.infinity,
            color: context.moonColors!.trunks,
          ),
          kPadding2.gap,
          Text(
            t.band.emptyAction,
            style: context.moonTypography!.body.text16.copyWith(
                color: context.moonColors!.trunks, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
