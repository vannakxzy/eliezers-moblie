import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../core/constants/size_constant.dart';
import '../../../../gen/i18n/translations.g.dart';

class PrivateAccountWidget extends StatefulWidget {
  const PrivateAccountWidget({super.key});

  @override
  State<PrivateAccountWidget> createState() => _PrivateAccountWidgetState();
}

class _PrivateAccountWidgetState extends State<PrivateAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kPadding),
      padding: const EdgeInsets.all(kPadding2),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(kPadding2),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all()),
              child: const Icon(
                MoonIcons.security_lock_24_light,
                size: 50,
              ),
            ),
            kPadding2.gap,
            Text(
              t.profileInfo.privateAccountMessage,
              textAlign: TextAlign.center,
              style: context.moonTypography!.body.text18
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
