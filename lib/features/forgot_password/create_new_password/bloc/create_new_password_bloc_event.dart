part of 'create_new_password_bloc_bloc.dart';

class CreateNewPasswordBlocEvent extends BaseEvent {}

@freezed
class PasswordChangedEvent extends CreateNewPasswordBlocEvent
    with _$PasswordChangedEvent {
  factory PasswordChangedEvent(String password) = _PasswordChangedEvent;
}

@freezed
class ClickCreateNewPassword extends CreateNewPasswordBlocEvent
    with _$ClickCreateNewPassword {
  factory ClickCreateNewPassword(String email) = _ClickCreateNewPassword;
}
