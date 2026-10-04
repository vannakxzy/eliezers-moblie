import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/icon_constant.dart';
import '../../profile/bottomsheet/bottom_sheet_list_tile.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';

class DisplayImageBottomsheet extends StatelessWidget {
  final ValueChanged<displayImageEnum> onTap;
  final bool isYourImage;
  const DisplayImageBottomsheet(
      {super.key, required this.onTap, required this.isYourImage});

  static Future<void> show(
          BuildContext context, ValueChanged ontap, bool isYourImage) =>
      showModalBottomSheet(
        context: context,
        builder: (_) => DisplayImageBottomsheet(
          onTap: ontap,
          isYourImage: isYourImage,
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
          BottomSheetListTile(
              leading: const Icon(MiconDownloadImage),
              title: t.common.downloadImage,
              onTap: (value) => onTap(displayImageEnum.downloadImage)),
          if (!isYourImage)
            BottomSheetListTile(
                leading: const Icon(MiconReport),
                title: "${t.common.report} ${t.common.photo}",
                onTap: (value) => onTap(displayImageEnum.report)),
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

enum displayImageEnum { downloadImage, report }
