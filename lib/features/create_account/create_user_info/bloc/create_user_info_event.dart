part of 'create_user_info_bloc.dart';

abstract class CreateUserInfoEvent extends BaseEvent {}

@freezed
class InitialEvent extends CreateUserInfoEvent with _$InitialEvent {
  factory InitialEvent(String email, String otp) = _InitialEvent;
}

@freezed
class NameChangedEvent extends CreateUserInfoEvent with _$NameChangedEvent {
  factory NameChangedEvent(String value) = _NameChangedEvent;
}

@freezed
class PasswordChangedEvent extends CreateUserInfoEvent
    with _$PasswordChangedEvent {
  factory PasswordChangedEvent(String value) = _PasswordChangedEvent;
}

@freezed
class ConfirmPasswordChangedEvent extends CreateUserInfoEvent
    with _$ConfirmPasswordChangedEvent {
  factory ConfirmPasswordChangedEvent(String value) =
      _ConfirmPasswordChangedEvent;
}

@freezed
class TogglePasswordEvent extends CreateUserInfoEvent
    with _$TogglePasswordEvent {
  factory TogglePasswordEvent() = _TogglePasswordEvent;
}

@freezed
class ToggleConfirmPasswordEvent extends CreateUserInfoEvent
    with _$ToggleConfirmPasswordEvent {
  factory ToggleConfirmPasswordEvent() = _ToggleConfirmPasswordEvent;
}

@freezed
class ClickCreateAccountEvent extends CreateUserInfoEvent
    with _$ClickCreateAccountEvent {
  factory ClickCreateAccountEvent() = _ClickCreateAccountEvent;
}

@freezed
class ConfirmTnC extends CreateUserInfoEvent with _$ConfirmTnC {
  factory ConfirmTnC(bool? valueChanged) = _ConfirmTnC;
}

@freezed
class ClickTermAndConfition extends CreateUserInfoEvent
    with _$ClickTermAndConfition {
  factory ClickTermAndConfition() = _ClickTermAndConfition;
}
