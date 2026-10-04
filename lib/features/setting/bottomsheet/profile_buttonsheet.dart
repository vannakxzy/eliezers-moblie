import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/icon_constant.dart';
import '../../profile/bottomsheet/bottom_sheet_list_tile.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';

class ProfileButtomSheet extends StatelessWidget {
  final bool isYour;
  const ProfileButtomSheet({
    super.key,
    this.isYour = false,
  });

  static Future<actionEnum> showBottomSheet({
    required BuildContext context,
    bool isYour = false,
  }) async =>
      await showModalBottomSheet(
        context: context,
        builder: (_) => ProfileButtomSheet(
          isYour: isYour,
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
          const Gap(kPadding),
          if (!isYour)
            BottomSheetListTile(
                leading: const Icon(MiconBlock),
                title: t.common.block,
                onTap: (value) {
                  Navigator.pop(context, actionEnum.block);
                }),
          if (!isYour)
            BottomSheetListTile(
                leading: const Icon(MiconReport),
                title: t.common.report,
                onTap: (value) {
                  Navigator.pop(context, actionEnum.report);
                }),
          if (!isYour)
            BottomSheetListTile(
                leading: const Icon(MiconSend),
                title: t.common.send,
                onTap: (value) {
                  Navigator.pop(context, actionEnum.share);
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

enum actionEnum {
  downloadImage,
  edit,
  delete,
  hide,
  report,
  block,
  send,
  share,
  like,
  save,
  merge
}
