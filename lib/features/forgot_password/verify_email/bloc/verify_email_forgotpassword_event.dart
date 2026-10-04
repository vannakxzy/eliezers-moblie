part of 'verify_email_forgotpassword_bloc.dart';

class VerifyEmailForgotpasswordEvent extends BaseEvent {}

@freezed
class InitPageEvent extends VerifyEmailForgotpasswordEvent
    with _$InitPageEvent {
  factory InitPageEvent(String email) = _InitPageEvent;
}

@freezed
class ClickVerityEvent extends VerifyEmailForgotpasswordEvent
    with _$ClickVerityEvent {
  factory ClickVerityEvent({required String otp}) = _ClickVerityEvent;
}

@freezed
class OtpChangedEvent extends VerifyEmailForgotpasswordEvent
    with _$OtpChangedEvent {
  factory OtpChangedEvent({
    required String otp,
  }) = _OtpChangedEvent;
}
