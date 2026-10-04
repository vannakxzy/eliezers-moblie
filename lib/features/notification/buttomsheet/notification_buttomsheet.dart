import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/icon_constant.dart';
import '../presentation/widgets/notification_card.dart';
import '../../profile/bottomsheet/bottom_sheet_list_tile.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';

class NotificationButtomsheet extends StatelessWidget {
  final ValueChanged<NotificationEnum> onTap;
  const NotificationButtomsheet({
    super.key,
    required this.onTap,
  });

  static Future<void> show(
          BuildContext context, ValueChanged<NotificationEnum> onTap) =>
      showModalBottomSheet(
        context: context,
        builder: (_) => NotificationButtomsheet(onTap: onTap),
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
              leading: const Icon(MiconDelete),
              title: t.notification.delete,
              onTap: (value) => onTap(NotificationEnum.delete)),
          // BottomSheetListTile(
          //     leading: const Icon(MiconHide),
          //     title: t.notification.hideThisType,
          //     onTap: (value) => onTap(NotificationEnum.hideThisType)),
          BottomSheetListTile(
              leading: const Icon(MiconReport),
              title: t.notification.reportToTeam,
              onTap: (value) => onTap(NotificationEnum.report)),
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
