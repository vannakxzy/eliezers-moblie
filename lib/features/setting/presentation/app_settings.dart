import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../config/router/page_route/app_route_info.dart';
import '../../../gen/i18n/translations.g.dart';

enum AppSettings {
  // app settings
  personalInfo(
    route: AppRouteInfo.personalInfo(),
    icon: MoonIcons.generic_user_32_regular,
    trailing: MoonIcons.controls_chevron_right_32_regular,
  ),
  appearance(
    route: AppRouteInfo.appearance(),
    icon: MoonIcons.generic_lightning_bolt_32_regular,
    trailing: MoonIcons.controls_chevron_right_32_regular,
  ),
  notification(
    route: AppRouteInfo.settingNotification(),
    icon: MoonIcons.notifications_bell_32_regular,
    trailing: MoonIcons.controls_chevron_right_32_regular,
  ),
  // privacy(
  //   route: AppRouteInfo.privacyData(),
  //   icon: MoonIcons.security_shield_secured_32_regular,
  //   trailing: MoonIcons.controls_chevron_right_32_regular,
  // ),
  security(
    route: AppRouteInfo.securityAndLogin(),
    icon: MoonIcons.security_lock_32_regular,
    trailing: MoonIcons.controls_chevron_right_32_regular,
  ),
  language(
    icon: MoonIcons.maps_world_32_regular,
  ),

  help(
    icon: MoonIcons.generic_idea_32_regular,
    enabled: false,
  ),
  feedback(
    route: AppRouteInfo.feedback(),
    icon: MoonIcons.chat_chat_32_regular,
  ),

  // appearances
  theme(
    icon: MoonIcons.other_moon_32_regular,
  ),

  // security
  block(
    icon: MoonIcons.generic_block_32_regular,
  ),
  hide(
    icon: MoonIcons.controls_eye_32_regular,
  ),
  changePassword(
    icon: MoonIcons.security_lock_32_regular,
  ),
  activeSession(
    icon: MoonIcons.devices_smartphone_32_regular,
  ),
  logout(
    icon: MoonIcons.generic_log_out_32_regular,
  ),
  deleteAccount(
    icon: MoonIcons.generic_delete_32_regular,
  ),
  ;

  static List<AppSettings> get mainSettings => [
        personalInfo,
        appearance,
        notification,
        // privacy,
        security,
        language,
        // help,
        feedback,
      ];

  static List<AppSettings> get appearances => [
        theme,
      ];

  static List<AppSettings> get securities => [
        block,
        hide,
        changePassword,
        activeSession,
        logout,
        deleteAccount,
      ];

  const AppSettings({
    this.route,
    this.enabled = true,
    this.icon,
    this.trailing,
  });

  final bool enabled;
  final AppRouteInfo? route;
  final IconData? icon;
  final IconData? trailing;

  Color? color(BuildContext context) {
    switch (this) {
      case deleteAccount:
        return context.moonColors?.chichi;
      default:
        return context.moonColors?.piccolo;
    }
  }

  Color? textColor(BuildContext context) {
    switch (this) {
      case deleteAccount:
        return context.moonColors?.chichi;
      default:
        return null;
    }
  }

  String get getTitle {
    switch (this) {
      case personalInfo:
        return t.setting.personalInfo;
      case appearance:
        return t.appearance.title;
      case notification:
        return t.setting.notification;
      // case privacy:
      //   return t.privacy.title;
      case security:
        return t.setting.securityLogin;
      case language:
        return t.setting.language;
      case help:
        return t.setting.help;
      case feedback:
        return t.setting.feedback;
      case theme:
        return t.setting.theme;
      case block:
        return t.common.block;
      case hide:
        return t.common.hide;
      case changePassword:
        return t.common.changePassword;
      case activeSession:
        return t.activeSession.title;
      case logout:
        return t.common.logOut;
      case deleteAccount:
        return t.securtyLogin.deleteAccount;
    }
  }

  String get getSubTitle {
    switch (this) {
      case personalInfo:
        return t.setting.personalInfoDes;
      case appearance:
        return t.setting.appearanceDes;
      case notification:
        return t.setting.notificationDes;
      // case AppSettings.privacy:
      //   return t.setting.privacyDes;
      case AppSettings.security:
        return t.setting.securityLoginDes;
      case AppSettings.language:
        return t.setting.languageDes;
      case AppSettings.help:
        return t.setting.helpDes;
      case AppSettings.feedback:
        return t.setting.feedbackDes;
      case AppSettings.theme:
        return t.setting.themeDes;
      case AppSettings.block:
        return t.setting.blockDes;
      case AppSettings.hide:
        return t.setting.hideDes;
      case AppSettings.changePassword:
        return t.setting.changePasswordDes;
      case AppSettings.activeSession:
        return t.setting.activeSessionDes;
      case AppSettings.logout:
        return t.setting.logOutDes;
      case AppSettings.deleteAccount:
        return t.setting.deleteAccountDes;
    }
  }
}
