import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecase/get_setting_usecase.dart';
import '../../domain/usecase/update_setting_usecase.dart';

import '../../../../app/base/bloc/bloc.dart';
import '../../../../data/data_sources/remotes/setting_api_service.dart';
import '../../domain/entities/setting_entity.dart';
import '../../setting_notifcation/bloc/setting_notification_bloc.dart';

part 'privacy_data_bloc.freezed.dart';
part 'privacy_data_event.dart';
part 'privacy_data_state.dart';

@Injectable()
class PrivacyDataBloc extends BaseBloc<PrivacyDataEvent, PrivacyDataState> {
  PrivacyDataBloc(this._getSettingUserCase, this._updateSettingUsecase)
      : super(const PrivacyDataState()) {
    on<GetSettingEvent>(_getSetting);
    on<ClickUpdateSetting>(_updateSetting);
  }
  final GetSettingUserCase _getSettingUserCase;
  final UpdateSettingUsecase _updateSettingUsecase;
  FutureOr _getSetting(
      GetSettingEvent event, Emitter<PrivacyDataState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(loading: true));
        final setting = await _getSettingUserCase.excecute();
        emit(state.copyWith(loading: false, setting: setting));
      },
      onError: (error) async {
        debugPrint("you got error $error");
        emit(state.copyWith(loading: false));
      },
    );
  }

  FutureOr _updateSetting(
      ClickUpdateSetting event, Emitter<PrivacyDataState> emit) async {
    await runAppCatching(
      () async {
        SettingEntity setting = state.setting!;
        final currentSetting = setting;

        bool value = false;
        if (event.typr == settingEnum.privateAccount) {
          value = !currentSetting.private_account;
          setting = currentSetting.copyWith(private_account: value);
        }
        if (event.typr == settingEnum.showAacl) {
          value = !currentSetting.show_aacl;
          setting = currentSetting.copyWith(show_aacl: value);
        }
        if (event.typr == settingEnum.showAnswer) {
          value = !currentSetting.show_answer;
          setting = currentSetting.copyWith(show_answer: value);
        }
        if (event.typr == settingEnum.showQuestion) {
          value = !currentSetting.show_question;
          setting = currentSetting.copyWith(show_question: value);
        }
        emit(state.copyWith(setting: setting));
        final settingUpdate = state.setting;
        await _updateSettingUsecase.excecute(UpdateSettingInput(
            notification: settingUpdate!.notification,
            notification_answer: settingUpdate.notification_answer,
            notification_comment: settingUpdate.notification_comment,
            notification_correct: settingUpdate.notification_correct,
            notification_like: settingUpdate.notification_like,
            private_account: settingUpdate.private_account,
            show_aacl: settingUpdate.show_aacl,
            show_answer: settingUpdate.show_answer,
            show_question: settingUpdate.show_question));
      },
    );
  }
}
