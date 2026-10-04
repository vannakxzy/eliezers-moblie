part of 'setting_notification_bloc.dart';

class SettingNotificationEvent extends BaseEvent {}

@freezed
class GetSettingEventP extends SettingNotificationEvent
    with _$GetSettingEventP {
  factory GetSettingEventP() = _GetSettingEventP;
}

@freezed
class ClickUpdateSettingNotificationEvent extends SettingNotificationEvent
    with _$ClickUpdateSettingNotificationEvent {
  factory ClickUpdateSettingNotificationEvent(settingEnum typr) =
      _ClickUpdateSettingNotificationEvent;
}
