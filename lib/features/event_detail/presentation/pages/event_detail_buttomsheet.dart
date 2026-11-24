import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/icon_constant.dart';
import '../../../../core/constants/size_constant.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../../../profile/bottomsheet/bottom_sheet_list_tile.dart';

class EventDetailButtomsheet extends StatelessWidget {
  final ValueChanged<eventDetialEm> onTap;
  final bool isown;
  const EventDetailButtomsheet(
      {super.key, required this.onTap, required this.isown});

  static Future<void> show(
          BuildContext context, ValueChanged ontap, bool isown) =>
      showModalBottomSheet(
        context: context,
        builder: (_) => EventDetailButtomsheet(
          onTap: ontap,
          isown: isown,
        ),
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
          Gap(kPadding),
          BottomSheetListTile(
              leading: const Icon(MiconEdit),
              title: t.common.edit,
              onTap: (value) => onTap(eventDetialEm.edit)),
          BottomSheetListTile(
              leading: const Icon(MiconDelete),
              title: t.common.delete,
              onTap: (value) => onTap(eventDetialEm.delete)),
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

enum eventDetialEm { edit, delete }
