import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../tab/bottom_tab.dart';
import 'package:moon_design/moon_design.dart';

class TabBarItem extends StatelessWidget {
  final BottomTab bottomTab;
  final GestureTapCallback onTap;
  final TabsRouter tabsRouter;
  const TabBarItem(
      {super.key,
      required this.bottomTab,
      required this.onTap,
      required this.tabsRouter});

  bool get isHomeTab => bottomTab == BottomTab.band;
  bool get isProfile => bottomTab == BottomTab.profile;
  // bool get isNotificationTab => bottomTab == BottomTab.notification;

  bool get isActive => bottomTab.index == tabsRouter.activeIndex;

  IconData get icon => bottomTab.icon;
  IconData get activeIcon => bottomTab.activeIcon;
  String get title => bottomTab.title;
  int get index => bottomTab.index;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? context.moonColors?.piccolo
        : context.moonColors!.bulma.withOpacity(0.8);
    return InkWell(
      highlightColor: Colors.transparent,
      splashFactory: InkSparkle.splashFactory,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 26),
            // isActive
            //     ? Container(
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: AppColor.primaryColor,
            //         ),
            //         height: 5,
            //         width: 5,
            //       )
            //     : SizedBox()
          ],
        ),
      ),
    );
  }
}
