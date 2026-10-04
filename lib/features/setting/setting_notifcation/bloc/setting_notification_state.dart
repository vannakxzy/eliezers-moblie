part of 'setting_notification_bloc.dart';

@freezed
class SettingNotificationState extends BaseState with _$SettingNotificationState {
  const factory SettingNotificationState({
    SettingEntity? setting,
    @Default(true) bool loadingSetting
  }) = _Initial;
}
