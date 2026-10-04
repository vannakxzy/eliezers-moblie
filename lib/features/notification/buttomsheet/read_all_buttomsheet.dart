import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';
import '../../profile/bottomsheet/bottom_sheet_list_tile.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';

class ReadAllButtomsheet extends StatelessWidget {
  const ReadAllButtomsheet({
    super.key,
  });

  static Future<bool> show(BuildContext context) async =>
      await showModalBottomSheet(
        context: context,
        builder: (_) => ReadAllButtomsheet(),
        backgroundColor: Colors.transparent,
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(kPadding2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(kPadding),
          BottomSheetListTile(
              leading: const Icon(MoonIcons.mail_envelope_24_regular),
              title: t.notification.markReadAll,
              onTap: (value) {
                Navigator.pop(context, true);
              }),
          const Gap(kPadding),
        ],
      ),
    );
  }
}
