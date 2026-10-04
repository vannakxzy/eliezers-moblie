import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../constants/constants.dart';

class CustomSeeMorePage extends StatelessWidget {
  final String title;
  final Function ontap;
  const CustomSeeMorePage(
      {super.key, required this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        margin: const EdgeInsets.only(top: kPadding, bottom: kPadding),
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.all(kPadding),
        decoration: BoxDecoration(
            color: context.moonColors!.beerus,
            borderRadius: BorderRadius.circular(kPadding)),
        child: Text(
          title,
          style: context.moonTypography!.body.text16,
        ),
      ),
    );
  }
}
