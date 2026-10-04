part of 'verify_email_bloc.dart';

class VerifyEmailEvent extends BaseEvent {}

@freezed
class InitPageEvent extends VerifyEmailEvent with _$InitPageEvent {
  factory InitPageEvent(String email) = _InitPageEvent;
}

@freezed
class ClickVerityEvent extends VerifyEmailEvent with _$ClickVerityEvent {
  factory ClickVerityEvent(
      {required BuildContext context,
      required String otp,
      required String email}) = _ClickVerityEvent;
}

@freezed
class OtpChangedEvent extends VerifyEmailEvent with _$OtpChangedEvent {
  factory OtpChangedEvent({
    required String otp,
  }) = _OtpChangedEvent;
}
