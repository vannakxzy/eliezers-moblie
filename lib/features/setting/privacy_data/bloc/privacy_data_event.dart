part of 'privacy_data_bloc.dart';

class PrivacyDataEvent extends BaseEvent {}

@freezed
class GetSettingEvent extends PrivacyDataEvent with _$GetSettingEvent {
  factory GetSettingEvent() = _GetSettingEvent;
}

@freezed
class ClickUpdateSetting extends PrivacyDataEvent with _$ClickUpdateSetting {
  factory ClickUpdateSetting(settingEnum typr) = _ClickUpdateSetting;
}
