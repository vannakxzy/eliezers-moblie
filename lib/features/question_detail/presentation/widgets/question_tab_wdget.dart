import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class QuestionTabWdget extends StatelessWidget {
  final bool isActive;
  final String label;
  const QuestionTabWdget({
    super.key,
    required this.isActive,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return isActive
        ? Tab(
            child: Text(label,
                style: context.moonTypography!.heading.text14
                    .copyWith(color: context.moonColors!.piccolo)),
          )
        : Tab(
            child: Text(label,
                style: context.moonTypography!.body.text14
                    .copyWith(color: context.moonColors!.trunks)),
          );
  }
}
