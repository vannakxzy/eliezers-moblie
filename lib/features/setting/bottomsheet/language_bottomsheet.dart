import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import '../../profile/bottomsheet/bottom_sheet_list_tile.dart';

import '../../../core/constants/constants.dart';
import '../../../gen/i18n/translations.g.dart';

class ChooseLanguageBottomSheet extends StatelessWidget {
  const ChooseLanguageBottomSheet({super.key});

  static Future<void> showBottomSheet(BuildContext context) =>
      showMoonModalBottomSheet(
        context: context,
        builder: (_) => const ChooseLanguageBottomSheet(),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.all(kPadding2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetTitle(
            title: t.setting.selectLanguage,
            leading: const Icon(Icons.translate_rounded),
          ),
          ...AppLocale.values.map(
            (item) => MoonMenuItem(
              height: context.moonSizes?.xl,
              // backgroundColor: Colors.red,
              trailing: item == LocaleSettings.instance.currentLocale
                  ? const Icon(Icons.done)
                  : null,
              label: Text(item.getTitle),
              onTap: () {
                LocaleSettings.instance.setLocale(item);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

extension Language on AppLocale {
  String get getTitle {
    switch (this) {
      case AppLocale.en:
        return 'English';
      case AppLocale.km:
        return 'ខ្មែរ';
    }
  }
}
