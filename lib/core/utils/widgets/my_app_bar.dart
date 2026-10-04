import 'package:flutter/material.dart';
import '../../../config/router/app_router.dart';
import '../../../di/di.dart';
import 'package:moon_design/moon_design.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: MoonButton.icon(
        icon: Icon(
          MoonIcons.arrows_left_16_regular,
          size: MoonSizes.sizes.sm,
        ),
        onTap: () {
          getIt.get<AppRouter>().maybePop();
        },
      ),
      toolbarHeight: 30,
    );
  }
}
