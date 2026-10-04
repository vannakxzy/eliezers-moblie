part of 'forgot_password_bloc.dart';

class ForgotPasswordEvent extends BaseEvent {}

@freezed
class EmailChangedEventEvent extends ForgotPasswordEvent
    with _$EmailChangedEventEvent {
  factory EmailChangedEventEvent(String value) = _EmailChangedEventEvent;
}

@freezed
class ClickConfirmEventEvent extends ForgotPasswordEvent
    with _$ClickConfirmEventEvent {
  factory ClickConfirmEventEvent() = _ClickConfirmEventEvent;
}
