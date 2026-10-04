import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../setting/alert/delete_account_alert.dart';
import '../../../setting/presentation/app_settings.dart';
import '../../../../gen/i18n/translations.g.dart';

import '../../../../app/base/page/base_page_bloc_state.dart';
import '../../../../core/constants/constants.dart';
import '../../../setting/alert/logout_alert.dart';
import '../../../setting/presentation/widgets/setting_item.dart';
import '../bloc/bloc.dart';

@RoutePage()
class SecurityLoginPage extends StatefulWidget {
  const SecurityLoginPage({super.key});

  @override
  State<SecurityLoginPage> createState() => _SecurityLoginPageState();
}

class _SecurityLoginPageState
    extends BasePageBlocState<SecurityLoginPage, SecurityLoginBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: t.securtyLogin.securtyLogin,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: kPadding2),
          itemCount: AppSettings.securities.length,
          itemBuilder: (_, index) {
            final setting = AppSettings.securities[index];
            String authType =
                LocalStorage.getStringValue(SharedPreferenceKeys.authType);
            if (setting.event == ClickChangePasswordEvent() &&
                authType == SharedPreferenceKeys.email) {
              return const SizedBox();
            }
            return SettingItem(
              onTap: () async {
                if (setting.event != null) {
                  if (setting.event == ClickLogoutEvent()) {
                    bool done = await LogoutAlert.show(context);
                    if (done) bloc.add(ClickLogoutEvent());
                  } else if (setting.event == DeleteAccount()) {
                    final done = await DeleteAccountAlert.show(context);
                    if (done == true) {
                      bloc.add(DeleteAccount());
                    }
                  } else {
                    bloc.add(setting.event!);
                  }
                }
              },
              setting: setting,
            );
          },
          separatorBuilder: (_, __) => const Gap(kPadding),
        ),
      ),
    );
  }
}

extension on AppSettings {
  SecurityLoginEvent? get event {
    switch (this) {
      case AppSettings.block:
        return ClickBlockEvent();
      case AppSettings.hide:
        return ClickHideEvent();
      case AppSettings.changePassword:
        return ClickChangePasswordEvent();
      case AppSettings.activeSession:
        return ClickActiveSession();
      case AppSettings.logout:
        return ClickLogoutEvent();
      case AppSettings.deleteAccount:
        return DeleteAccount();
      default:
        return null;
    }
  }
}
