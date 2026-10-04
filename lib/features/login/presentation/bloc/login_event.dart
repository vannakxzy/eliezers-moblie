part of 'login_bloc.dart';

@freezed
class LoginEvent extends BaseEvent with _$LoginEvent {
  const factory LoginEvent.EmailChangedEvent(String email) = _EmailChangedEvent;
  const factory LoginEvent.passwordChanged(String password) = _PasswordChanged;
  const factory LoginEvent.clickedButtonLogin() = _ClickedButtonLogin;
  const factory LoginEvent.clickLoginWithGmail() = _ClickLoginWithGmail;
  const factory LoginEvent.clickForgotPassword() = _ClickForgotPassword;
}
