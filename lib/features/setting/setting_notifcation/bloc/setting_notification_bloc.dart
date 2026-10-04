import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/base/bloc/base_bloc.dart';
import '../../../../app/base/bloc/base_event.dart';
import '../../../../app/base/bloc/base_state.dart';
import '../../../../data/data_sources/remotes/setting_api_service.dart';
import '../../domain/entities/setting_entity.dart';
import '../../domain/usecase/get_setting_usecase.dart';
import '../../domain/usecase/update_setting_usecase.dart';

part 'setting_notification_event.dart';
part 'setting_notification_state.dart';
part 'setting_notification_bloc.freezed.dart';

@Injectable()
class SettingNotificationBloc
    extends BaseBloc<SettingNotificationEvent, SettingNotificationState> {
  SettingNotificationBloc(this._getSettingUserCase, this._updateSettingUsecase)
      : super(const _Initial()) {
    on<GetSettingEventP>(_getSetting);
    on<ClickUpdateSettingNotificationEvent>(_updateSettingNotification);
  }
  final GetSettingUserCase _getSettingUserCase;
  final UpdateSettingUsecase _updateSettingUsecase;

  FutureOr _getSetting(
      GetSettingEventP event, Emitter<SettingNotificationState> emit) async {
    await runAppCatching(
      () async {
        emit(state.copyWith(loadingSetting: true));
        // ignore: void_checks
        final setting = await _getSettingUserCase.excecute('');
        emit(state.copyWith(setting: setting, loadingSetting: false));
      },
      onError: (error) async {
        emit(state.copyWith(loadingSetting: false));
      },
    );
  }

  FutureOr _updateSettingNotification(ClickUpdateSettingNotificationEvent event,
      Emitter<SettingNotificationState> emit) async {
    SettingEntity setting = state.setting!;
    final currentSetting = setting;
    bool value = false;
    if (event.typr == settingEnum.notification) {
      value = !currentSetting.notification;
      setting = currentSetting.copyWith(notification: value);
    }
    if (event.typr == settingEnum.notificationComment) {
      value = !currentSetting.notification_comment;
      setting = currentSetting.copyWith(notification_comment: value);
    }
    if (event.typr == settingEnum.notificationAnswer) {
      value = !currentSetting.notification_answer;
      setting = currentSetting.copyWith(notification_answer: value);
    }
    if (event.typr == settingEnum.notificationLike) {
      value = !currentSetting.notification_like;
      setting = currentSetting.copyWith(notification_like: value);
    }
    if (event.typr == settingEnum.notificationCorrect) {
      value = !currentSetting.notification_correct;
      setting = currentSetting.copyWith(notification_correct: value);
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
  }
}

enum settingEnum {
  privateAccount,
  showAacl,
  showAnswer,
  showQuestion,
  notification,
  notificationLike,
  notificationComment,
  notificationAnswer,
  notificationCorrect
}
