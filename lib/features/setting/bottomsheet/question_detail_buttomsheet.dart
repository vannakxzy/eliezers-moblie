import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/icon_constant.dart';
import '../../profile/bottomsheet/bottom_sheet_list_tile.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';

class QuestionDetailButtonsheet extends StatelessWidget {
  final bool isYour;
  final String image;
  final ValueChanged<questionMoreEnum> onTap;
  const QuestionDetailButtonsheet({
    super.key,
    required this.isYour,
    required this.image,
    required this.onTap,
  });

  static Future<void> showBottomSheet(BuildContext context, bool isYour,
          String image, ValueChanged ontap) =>
      showModalBottomSheet(
        context: context,
        builder: (_) => QuestionDetailButtonsheet(
          isYour: isYour,
          image: image,
          onTap: ontap,
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
          if (image != "")
            BottomSheetListTile(
                leading: const Icon(MiconDownloadImage),
                title: t.common.downloadImage,
                onTap: (value) => onTap(questionMoreEnum.downloadImage)),
          if (isYour)
            BottomSheetListTile(
                leading: const Icon(MiconEdit),
                title: t.common.edit,
                onTap: (value) => onTap(questionMoreEnum.edit)),
          if (isYour)
            BottomSheetListTile(
                leading: const Icon(MiconDelete),
                title: t.common.delete,
                onTap: (value) => onTap(questionMoreEnum.delete)),
          if (!isYour)
            BottomSheetListTile(
                leading: const Icon(MiconHide),
                title: t.common.hide,
                onTap: (value) => onTap(questionMoreEnum.hide)),
          if (!isYour)
            BottomSheetListTile(
                leading: const Icon(MiconReport),
                title: t.common.report,
                onTap: (value) => onTap(questionMoreEnum.report)),
          BottomSheetListTile(
              leading: const Icon(MiconSend),
              title: t.common.send,
              onTap: (value) => onTap(questionMoreEnum.share)),
          if (!isYour)
            BottomSheetListTile(
                leading: const Icon(MiconBlock),
                title: t.common.block,
                onTap: (value) => onTap(questionMoreEnum.block)),
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

enum questionMoreEnum {
  downloadImage,
  edit,
  delete,
  hide,
  report,
  block,
  share
}
