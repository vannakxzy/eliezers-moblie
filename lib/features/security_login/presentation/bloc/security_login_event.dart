part of 'security_login_bloc.dart';

class SecurityLoginEvent extends BaseEvent {}

@freezed
class ClickHideEvent extends SecurityLoginEvent with _$ClickHideEvent {
  factory ClickHideEvent() = _ClickHideEvent;
}

@freezed
class ClickBlockEvent extends SecurityLoginEvent with _$ClickBlockEvent {
  factory ClickBlockEvent() = _ClickBlockEvent;
}

@freezed
class ClickLogoutEvent extends SecurityLoginEvent with _$ClickLogoutEvent {
  factory ClickLogoutEvent() = _ClickLogoutEvent;
}

@freezed
class ClickChangePasswordEvent extends SecurityLoginEvent
    with _$ClickChangePasswordEvent {
  factory ClickChangePasswordEvent() = _ClickChangePasswordEvent;
}

@freezed
class ClickActiveSession extends SecurityLoginEvent with _$ClickActiveSession {
  factory ClickActiveSession() = _ClickActiveSession;
}

@freezed
class DeleteAccount extends SecurityLoginEvent with _$DeleteAccount {
  factory DeleteAccount() = _DeleteAccount;
}
