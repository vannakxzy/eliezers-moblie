import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/icon_constant.dart';
import '../../../core/utils/widgets/custom_answer_card.dart';
import '../../profile/bottomsheet/bottom_sheet_list_tile.dart';
import '../../profile/domain/entities/answer_entity.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';

class AnswerButtonsheet extends StatelessWidget {
  final AnswertEntity answer;
  final ValueChanged<answerEnum> onTap;
  const AnswerButtonsheet({
    super.key,
    required this.answer,
    required this.onTap,
  });

  static Future<void> showBottomSheet(BuildContext context,
          AnswertEntity answer, ValueChanged<answerEnum> ontap) =>
      showModalBottomSheet(
        context: context,
        builder: (_) => AnswerButtonsheet(
          answer: answer,
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
          if (answer.image.isNotEmpty)
            BottomSheetListTile(
              leading: const Icon(MiconDownloadImage),
              title: t.common.downloadImage,
              onTap: (value) => onTap(answerEnum.downloadImage),
            ),
          if (answer.is_your)
            BottomSheetListTile(
              leading: const Icon(MiconEdit),
              title: t.common.edit,
              onTap: (value) => onTap(answerEnum.edit),
            ),
          if (answer.is_your)
            BottomSheetListTile(
                leading: const Icon(MiconDelete),
                title: t.common.delete,
                onTap: (value) {
                  Navigator.pop(context);
                  onTap(answerEnum.delete);
                }),
          if (!answer.is_your)
            BottomSheetListTile(
                leading: const Icon(MiconReport),
                title: t.common.report,
                onTap: (value) {
                  Navigator.pop(context);
                  onTap(answerEnum.report);
                }),
          if (!answer.is_your)
            BottomSheetListTile(
                leading: const Icon(MiconBlock),
                title: t.common.block,
                onTap: (value) => onTap(answerEnum.block)),
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
