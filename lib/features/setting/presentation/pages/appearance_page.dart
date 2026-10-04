import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../app_settings.dart';
import '../bloc/bloc/appearance_bloc.dart';
import '../widgets/setting_item.dart';
import '../../../../gen/i18n/translations.g.dart';
import 'package:moon_design/moon_design.dart';

import '../../../../config/theme/theme_controller.dart';
import '../../../../core/constants/constants.dart';

@RoutePage()
class AppearancePage extends StatefulWidget {
  const AppearancePage({super.key});

  @override
  State<AppearancePage> createState() => _AppearancePageState();
}

class _AppearancePageState
    extends BasePageBlocState<AppearancePage, AppearanceBloc> {
  @override
  void initState() {
    bloc.add(InitPage());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: t.appearance.title),
      body: BlocBuilder<AppearanceBloc, AppearanceState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: kPadding2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...AppSettings.appearances.map(
                  (setting) => SettingItem(
                    setting: setting,
                    onTap: () {
                      bloc.add(ClickThemeEvent());
                    },
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // spacing: kPadding / 2,
                      children: [
                        ...ThemeMode.values.map(
                          (e) => Row(
                            children: [
                              // MoonRadio(
                              //   value: e,
                              //   groupValue:
                              //       context.watch<ThemeController>().state,
                              //   toggleable: true,
                              //   onChanged: (value) {},
                              // ),
                              if (e != ThemeMode.system)
                                Text(
                                  e.name.firstUpper(),
                                  style: context.moonTypography!.body.text12
                                      .copyWith(
                                    color: context
                                                .watch<ThemeController>()
                                                .state ==
                                            e
                                        ? context.moonColors?.piccolo
                                        : null,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

extension on ThemeMode {
  String get name {
    switch (this) {
      case ThemeMode.system:
        return t.setting.system;
      case ThemeMode.light:
        return t.setting.light;
      case ThemeMode.dark:
        return t.setting.dark;
    }
  }
}
