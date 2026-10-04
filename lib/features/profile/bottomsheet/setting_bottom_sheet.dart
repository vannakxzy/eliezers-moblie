import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../core/constants/constants.dart';

class SettingBottomSheet extends StatefulWidget {
  const SettingBottomSheet({super.key});

  @override
  State<SettingBottomSheet> createState() => _SettingBottomSheetState();

  static Future<SettingBottomSheets?> showBottomSheet(
          BuildContext context) async =>
      await showMoonModalBottomSheet(
          context: context,
          enableDrag: true,
          builder: (_) => const SettingBottomSheet());
}

class _SettingBottomSheetState extends State<SettingBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.symmetric(horizontal: kPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: ShapeDecoration(
              color: context.moonColors!.beerus,
              shape: MoonSquircleBorder(
                borderRadius: BorderRadius.circular(kRadius2)
                    .squircleBorderRadius(context),
              ),
            ),
          ),
          ...SettingBottomSheets.values.map(
            (item) => MoonMenuItem(
              onTap: () {
                Navigator.pop(context, item);
              },
              leading: Icon(item.icon),
              label: Text(item.getTitle),
            ),
          ),
        ],
      ),
    );
  }
}

enum SettingBottomSheets {
  setting(icon: MoonIcons.generic_settings_32_regular),
  myQr(icon: MoonIcons.security_qr_code_32_regular),
  logout(icon: MoonIcons.generic_log_out_32_regular);

  const SettingBottomSheets({this.icon});
  final IconData? icon;

  String get getTitle {
    switch (this) {
      case SettingBottomSheets.setting:
        return 'Setting';
      case SettingBottomSheets.myQr:
        return 'My QR';
      case SettingBottomSheets.logout:
        return 'Log out';
    }
  }
}
