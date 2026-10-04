part of 'verify_otp_login_bloc.dart';

class VerifyOtpLoginEvent extends BaseEvent {}

@freezed
class InitPageEvent extends VerifyOtpLoginEvent with _$InitPageEvent {
  factory InitPageEvent(String email) = _InitPageEvent;
}

@freezed
class ClickVerityEvent extends VerifyOtpLoginEvent with _$ClickVerityEvent {
  factory ClickVerityEvent(
      {required String otp,
      required String email,
      required String password}) = _ClickVerityEvent;
}

@freezed
class OtpChangedEvent extends VerifyOtpLoginEvent with _$OtpChangedEvent {
  factory OtpChangedEvent({
    required String otp,
  }) = _OtpChangedEvent;
}
