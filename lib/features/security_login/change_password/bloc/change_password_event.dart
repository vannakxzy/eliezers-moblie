part of 'change_password_bloc.dart';

class ChangePasswordEvent extends BaseEvent {
  // const factory ChangePasswordEvent.newPasswordChange(String value) =
  //     _NewPasswordChange;
  // const factory ChangePasswordEvent.reTypeNewPasswordChange(String value) =
  //     _ReTypeNewPasswordChange;
  // const factory ChangePasswordEvent.clickComfirm() = _ClickComfirm;
}

@freezed
class CurrentPasswordChangeEvent extends ChangePasswordEvent
    with _$CurrentPasswordChangeEvent {
  factory CurrentPasswordChangeEvent(String value) =
      _CurrentPasswordChangeEvent;
}

@freezed
class NewPasswordChangedEvent extends ChangePasswordEvent
    with _$NewPasswordChangedEvent {
  factory NewPasswordChangedEvent(String value) = _NewPasswordChangedEvent;
}

@freezed
class ReTypeNewPasswordEvent extends ChangePasswordEvent
    with _$ReTypeNewPasswordEvent {
  factory ReTypeNewPasswordEvent(String value) = _ReTypeNewPasswordEvent;
}

@freezed
class ClickConfirmEvent extends ChangePasswordEvent with _$ClickConfirmEvent {
  factory ClickConfirmEvent() = _ClickConfirmEvent;
}
