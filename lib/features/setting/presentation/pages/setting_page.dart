import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/constants.dart';
import 'package:moon_design/moon_design.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../../gen/i18n/translations.g.dart';
import '../app_settings.dart';
import '../bloc/bloc.dart';
import '../widgets/setting_item.dart';

@RoutePage()
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends BasePageBlocState<SettingPage, SettingBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: t.setting.setting,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding2),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: AppSettings.mainSettings.length,
          separatorBuilder: (context, index) => const Gap(kPadding),
          itemBuilder: (_, index) {
            final setting = AppSettings.mainSettings.elementAt(index);
            return SettingItem(
              onTap: () async {
                if (setting.route != null) {
                  appRoute.push(setting.route!);
                } else if (setting == AppSettings.language) {
                  bloc.add(ClickLanguangeEvent());
                  // setState(() {});
                } else if (setting == AppSettings.help) {
                  await launchUrl(
                      Uri.parse('https://eliezers.com/help-center'));
                }
                setState(() {});
              },
              setting: setting,
              trailing: setting == AppSettings.language
                  ? LocaleSettings.instance.currentLocale == AppLocale.en
                      ? Text("English",
                          style: context.moonTypography!.heading.text16)
                      : Text("ភាសាខ្មែរ",
                          style: context.moonTypography!.heading.text16)
                  : null,
            );
          },
        ),
      ),
    );
  }
}
