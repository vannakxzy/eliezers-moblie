import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../di/di.dart';
import 'package:moon_design/moon_design.dart';

import '../../../app/base/navigation/app_navigator.dart';
import '../../../config/router/page_route/app_route_info.dart';
import '../../../gen/i18n/translations.g.dart';
import '../../constants/constants.dart';
import 'custom_dialog.dart';

class CustomAnonymousCard extends StatefulWidget {
  const CustomAnonymousCard({
    super.key,
  });

  @override
  State<CustomAnonymousCard> createState() => _CustomAnonymousCardState();
}

class _CustomAnonymousCardState extends State<CustomAnonymousCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: () {
          getIt.get<IAppNavigator>().pop();
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
          child: CustomDialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.anonymous.title,
                  style: context.moonTypography!.heading.text20,
                ),
                Text(
                  t.anonymous.description,
                  style: context.moonTypography!.body.text14,
                ),
                s3.gap,
                MoonButton(
                  backgroundColor: context.moonColors!.piccolo,
                  buttonSize: MoonButtonSize.sm,
                  isFullWidth: true,
                  label: Text(
                    t.anonymous.buttonName,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    getIt.get<IAppNavigator>().pop();
                    getIt.get<IAppNavigator>().push(AppRouteInfo.login());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum ClickAnonymousType { close, leaveAnonymous }
