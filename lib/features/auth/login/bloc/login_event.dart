part of 'login_bloc.dart';

class LoginEvent extends BaseEvent {}

@freezed
class EmailChangedEvent extends LoginEvent with _$EmailChangedEvent {
  factory EmailChangedEvent(String value) = _EmailChangedEvent;
}

@freezed
class PasswordChange extends LoginEvent with _$PasswordChange {
  factory PasswordChange(String value) = _PasswordChange;
}

@freezed
class ClickButtonLogin extends LoginEvent with _$ClickButtonLogin {
  factory ClickButtonLogin() = _ClickButtonLogin;
}

@freezed
class ClickLoginWithEmail extends LoginEvent with _$ClickLoginWithEmail {
  factory ClickLoginWithEmail() = _ClickLoginWithEmail;
}

@freezed
class ClickForgotPassword extends LoginEvent with _$ClickForgotPassword {
  factory ClickForgotPassword() = _ClickForgotPassword;
}

@freezed
class ClickCreateEventAccountEvent extends LoginEvent
    with _$ClickCreateEventAccountEvent {
  factory ClickCreateEventAccountEvent() = _ClickCreateEventAccountEvent;
}

@freezed
class TogglePasswordVisibility extends LoginEvent
    with _$TogglePasswordVisibility {
  factory TogglePasswordVisibility() = _TogglePasswordVisibility;
}
