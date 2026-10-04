part of 'reset_password_bloc.dart';

class ResetPasswordEvent extends BaseEvent {}

@freezed
class PasswordChanged extends ResetPasswordEvent with _$PasswordChanged {
  factory PasswordChanged(String value) = _PasswordChanged;
}

@freezed
class ClickConfirmEvent extends ResetPasswordEvent with _$ClickConfirmEvent {
  factory ClickConfirmEvent(String email, String otp) = _ClickConfirmEvent;
}
