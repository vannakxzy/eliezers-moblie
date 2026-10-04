// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/i18n/translations.g.dart';
import 'package:moon_design/moon_design.dart';

class CustomGmailCard extends StatelessWidget {
  final GestureTapCallback ontap;
  const CustomGmailCard({
    super.key,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return MoonOutlinedButton(
      // borderRadius: BorderRadius.circular(kRadius2),
      borderColor: context.moonColors!.trunks,
      buttonSize: MoonButtonSize.lg,
      isFullWidth: true,
      onTap: ontap,
      showPulseEffect: false,
      leading: Assets.svg.gmail.svg(height: 24, width: 24),
      label: Text(
        t.login.loginWithGmail,
        style: context.moonTypography!.body.text14
            .copyWith(color: context.moonColors!.trunks),
      ),
    );
  }
}
