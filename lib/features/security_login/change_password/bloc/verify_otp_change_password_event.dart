part of 'verify_otp_change_password_bloc.dart';

class VerifyOtpChangePasswordEvent extends BaseEvent {}

@freezed
class InitPageEventP extends VerifyOtpChangePasswordEvent
    with _$InitPageEventP {
  factory InitPageEventP() = _InitPageEventP;
}

@freezed
class ClickVerityEvent extends VerifyOtpChangePasswordEvent
    with _$ClickVerityEvent {
  factory ClickVerityEvent(String otp, String password) = _ClickVerityEvent;
}

@freezed
class OtpChangedEvent extends VerifyOtpChangePasswordEvent
    with _$OtpChangedEvent {
  factory OtpChangedEvent(String otp) = _OtpChangedEvent;
}
