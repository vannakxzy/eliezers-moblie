import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../shared/widgets/app_divider.dart';

class SelectAudienceWidget extends StatelessWidget {
  final IconData leading;
  final String title;
  final String decoration;
  final bool isSelect;
  final Function ontap;
  const SelectAudienceWidget(
      {super.key,
      required this.leading,
      required this.title,
      required this.ontap,
      required this.decoration,
      required this.isSelect});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        padding: EdgeInsets.only(top: kPadding, bottom: kPadding),
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              leading,
              size: 35,
            ),
            kPadding.gap,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: context.moonTypography!.body.text16,
                      ),
                      if (isSelect)
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: context.moonColors!.piccolo),
                          ),
                          alignment: Alignment.center,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.moonColors!.piccolo),
                          ),
                        ),
                      if (!isSelect)
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    decoration,
                    style: context.moonTypography!.body.text14
                        .copyWith(color: context.moonColors!.trunks),
                  ),
                  kPadding.gap,
                  AppDivider.large(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
