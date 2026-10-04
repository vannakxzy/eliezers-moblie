part of 'verify_email_createaccount_bloc.dart';

class VerifyEmailCreateaccountEvent extends BaseEvent {}

@freezed
class InitPageEvent extends VerifyEmailCreateaccountEvent with _$InitPageEvent {
  factory InitPageEvent(String email) = _InitPageEvent;
}

@freezed
class ClickVerityEvent extends VerifyEmailCreateaccountEvent
    with _$ClickVerityEvent {
  factory ClickVerityEvent({required String otp, required String email}) =
      _ClickVerityEvent;
}

@freezed
class OtpChangedEvent extends VerifyEmailCreateaccountEvent
    with _$OtpChangedEvent {
  factory OtpChangedEvent({
    required String otp,
  }) = _OtpChangedEvent;
}
