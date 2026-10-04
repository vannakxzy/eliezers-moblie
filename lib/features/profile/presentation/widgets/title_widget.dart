import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../gen/i18n/translations.g.dart';

class TitleWidget extends StatelessWidget {
  final int count;
  final String title;
  final Function? ontap;
  const TitleWidget({
    super.key,
    this.count = 0,
    this.ontap,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title.toUpperCase(),
                  style: context.moonTypography!.body.text14.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
              if (count > 5)
                GestureDetector(
                  onTap: () {
                    if (ontap != null) {
                      ontap!();
                    }
                  },
                  child: Text(t.common.all.toUpperCase(),
                      style: context.moonTypography!.body.text12.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
