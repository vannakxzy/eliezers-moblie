import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../core/constants/constants.dart';

class AppTextDivider extends StatelessWidget {
  const AppTextDivider(this.text, {super.key, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Text(
            text,
            style: style ?? context.moonTypography?.body.text14,
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
