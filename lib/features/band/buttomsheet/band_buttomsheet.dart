import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/icon_constant.dart';
import '../../profile/bottomsheet/bottom_sheet_list_tile.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';

class BandDetailButtomsheet extends StatelessWidget {
  final ValueChanged<bandEnum> onTap;
  final bool owner;
  const BandDetailButtomsheet(
      {super.key, required this.onTap, required this.owner});

  static Future<void> showBottomSheet(
          BuildContext context, ValueChanged ontap, bool owner) =>
      showModalBottomSheet(
        context: context,
        builder: (_) => BandDetailButtomsheet(onTap: ontap, owner: owner),
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
          if (owner)
            BottomSheetListTile(
                leading: const Icon(MiconEdit),
                title: t.common.edit,
                onTap: (value) {
                  Navigator.pop(context);
                  onTap(bandEnum.edit);
                }),
          if (owner)
            BottomSheetListTile(
                leading: const Icon(MiconDelete),
                title: t.common.delete,
                onTap: (value) {
                  Navigator.pop(context);

                  onTap(bandEnum.delete);
                }),
          if (!owner)
            BottomSheetListTile(
                leading: const Icon(MiconReport),
                title: t.common.block,
                onTap: (value) {
                  onTap(bandEnum.report);
                }),
          const Gap(kPadding),
          BottomSheetListTile(
            title: t.common.cancel,
          ),
          const Gap(kPadding),
        ],
      ),
    );
  }
}

enum bandEnum { edit, delete, hide, report, block, share }
