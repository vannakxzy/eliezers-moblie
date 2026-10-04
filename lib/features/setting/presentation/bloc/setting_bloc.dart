// ignore_for_file: void_checks

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helper/local_data/storge_local.dart';
import '../../domain/entities/setting_entity.dart';
import '../../../../app/base/bloc/bloc.dart';
import '../../../../config/router/page_route/app_route_info.dart';
import '../../../../gen/i18n/translations.g.dart';

part 'setting_event.dart';
part 'setting_state.dart';
part 'setting_bloc.freezed.dart';

@Injectable()
class SettingBloc extends BaseBloc<SettingEvent, SettingState> {
  SettingBloc() : super(const _Initial()) {
    on<ClickFeedBackEvent>(_clickFeedBack);
    on<ClickHelpEvent>(_clickHelp);
    on<ClickLanguangeEvent>(_clickLanguage);
    on<ClickNotificationEvent>(_clickNotification);
    on<ClickPrivacyDataEvent>(_clickPrivacyData);
    on<ClickPernalInfoEvent>(_clicPersonalInfo);
    on<ClickSecurityLoginEvent>(_clickSecuriryLogin);
    on<ClickTermConditionEvent>(_clickTermCondition);
  }

  FutureOr<void> _clickLanguage(
      ClickLanguangeEvent event, Emitter<SettingState> emit) {
    final applocal = LocaleSettings.instance.currentLocale;
    if (applocal == AppLocale.en) {
      LocaleSettings.instance.setLocale(AppLocale.km);
      LocalStorage.storeData(key: SharedPreferenceKeys.languages, value: "km");
    } else {
      LocaleSettings.instance.setLocale(AppLocale.en);
      LocalStorage.storeData(key: SharedPreferenceKeys.languages, value: "en");
    }
  }

  FutureOr<void> _clickNotification(
      ClickNotificationEvent event, Emitter<SettingState> emit) {
    appRoute.push(const AppRouteInfo.notification());
  }

  FutureOr<void> _clickPrivacyData(
      ClickPrivacyDataEvent event, Emitter<SettingState> emit) {
    appRoute.push(const AppRouteInfo.privacyData());
  }

  FutureOr<void> _clicPersonalInfo(
      ClickPernalInfoEvent event, Emitter<SettingState> emit) {
    appRoute.push(const AppRouteInfo.personalInfo());
  }

  FutureOr<void> _clickSecuriryLogin(
      ClickSecurityLoginEvent event, Emitter<SettingState> emit) {
    appRoute.push(const AppRouteInfo.securityAndLogin());
  }

  FutureOr<void> _clickTermCondition(
      ClickTermConditionEvent event, Emitter<SettingState> emit) {}
  FutureOr<void> _clickHelp(ClickHelpEvent event, Emitter<SettingState> emit) {}
  FutureOr<void> _clickFeedBack(
      ClickFeedBackEvent event, Emitter<SettingState> emit) {
    appRoute.push(const AppRouteInfo.feedback());
  }
}
