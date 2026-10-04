part of 'setting_bloc.dart';

class SettingEvent extends BaseEvent {}

@freezed
class ClickPernalInfoEvent extends SettingEvent with _$ClickPernalInfoEvent {
  factory ClickPernalInfoEvent() = _ClickPernalInfoEvent;
}

@freezed
class ClickNotificationEvent extends SettingEvent
    with _$ClickNotificationEvent {
  factory ClickNotificationEvent() = _ClickNotificationEvent;
}

@freezed
class ClickPrivacyDataEvent extends SettingEvent with _$ClickPrivacyDataEvent {
  factory ClickPrivacyDataEvent() = _ClickPrivacyDataEvent;
}

@freezed
class ClickSecurityLoginEvent extends SettingEvent
    with _$ClickSecurityLoginEvent {
  factory ClickSecurityLoginEvent() = _ClickSecurityLoginEvent;
}

@freezed
class ClickHelpEvent extends SettingEvent with _$ClickHelpEvent {
  factory ClickHelpEvent() = _ClickHelpEvent;
}

@freezed
class ClickFeedBackEvent extends SettingEvent with _$ClickFeedBackEvent {
  factory ClickFeedBackEvent() = _ClickFeedBackEvent;
}

@freezed
class ClickLanguangeEvent extends SettingEvent with _$ClickLanguangeEvent {
  factory ClickLanguangeEvent() = _ClickLanguangeEvent;
}

@freezed
class ClickTermConditionEvent extends SettingEvent
    with _$ClickTermConditionEvent {
  factory ClickTermConditionEvent() = _ClickTermConditionEvent;
}
