import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/icon_constant.dart';
import '../../../core/utils/widgets/custom_comment_crad.dart';
import '../../profile/bottomsheet/bottom_sheet_list_tile.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';

class CommentButtomsheet extends StatelessWidget {
  final bool isYour;
  final ValueChanged<commentEnum> onTap;
  const CommentButtomsheet({
    super.key,
    required this.isYour,
    required this.onTap,
  });

  static Future<void> showBottomSheet(
          BuildContext context, bool isYour, ValueChanged<commentEnum> ontap) =>
      showModalBottomSheet(
        context: context,
        builder: (_) => CommentButtomsheet(
          isYour: isYour,
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
          if (isYour)
            BottomSheetListTile(
                leading: const Icon(MiconEdit),
                title: t.common.edit,
                onTap: (value) => onTap(commentEnum.edit)),
          if (isYour)
            BottomSheetListTile(
                leading: const Icon(MiconDelete),
                title: t.common.delete,
                onTap: (value) => onTap(commentEnum.delete)),
          if (!isYour)
            BottomSheetListTile(
                leading: const Icon(MiconReport),
                title: t.common.report,
                onTap: (value) => onTap(commentEnum.report)),
          if (!isYour)
            BottomSheetListTile(
                leading: const Icon(MiconReport),
                title: t.common.block,
                onTap: (value) => onTap(commentEnum.block)),
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
