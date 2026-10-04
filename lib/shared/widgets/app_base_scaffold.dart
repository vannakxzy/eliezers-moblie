import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';

import '../../core/constants/constants.dart';

class AppBaseScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget? bottomNavigationBar;
  final String title;
  final String description;
  final Widget child;
  const AppBaseScaffold({
    super.key,
    this.appBar,
    this.bottomNavigationBar,
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: kScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.moonTypography?.body.text40,
            ),
            const Gap(kPadding / 2),
            Text(
              description,
              style: context.moonTypography?.body.text16,
              textAlign: TextAlign.left,
            ),
            const Gap(kPadding2),
            child
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
