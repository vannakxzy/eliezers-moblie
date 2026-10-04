import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moon_design/moon_design.dart';
import '../../category/domain/entities/category_entity.dart';
import '../../profile/bottomsheet/bottom_sheet_list_tile.dart';
import 'profile_buttonsheet.dart';
import '../../../gen/i18n/translations.g.dart';

import '../../../core/constants/constants.dart';

class CategoryDetailButtonsheet extends StatelessWidget {
  final List<CategoryEntity> category;
  final int index;
  final ValueChanged<actionEnum> onTap;
  const CategoryDetailButtonsheet({
    super.key,
    required this.index,
    required this.onTap,
    required this.category,
  });

  static Future<void> showBottomSheet(
          {required BuildContext context,
          required int index,
          required ValueChanged ontap,
          required List<CategoryEntity> category}) =>
      showModalBottomSheet(
        context: context,
        builder: (_) => CategoryDetailButtonsheet(
          index: index,
          onTap: ontap,
          category: category,
        ),
        backgroundColor: Colors.transparent,
      );
  @override
  Widget build(BuildContext context) {
    int questionCount = category[index].count!;
    return SafeArea(
      minimum: const EdgeInsets.all(kPadding2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(kPadding),
          if (category.length > 1 && questionCount > 0)
            BottomSheetListTile(
              leading: const Icon(MoonIcons.text_cut_24_regular),
              title: t.common.merges,
              onTap: (value) => onTap(actionEnum.merge),
            ),
          BottomSheetListTile(
            leading: const Icon(MoonIcons.generic_edit_24_regular),
            title: t.common.edit,
            onTap: (value) => onTap(actionEnum.edit),
          ),
          if (category.length > 1)
            BottomSheetListTile(
                leading: const Icon(
                  MoonIcons.generic_delete_24_regular,
                ),
                title: t.common.delete,
                onTap: (value) => onTap(actionEnum.delete)),
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

enum questionMoreEnum { downloadImage, edit, delete, hide, report, block, send }
