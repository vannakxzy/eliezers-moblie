part of 'verify_email_bloc.dart';

@freezed
class VerifyEmailState extends BaseState with _$VerifyEmailState {
  const factory VerifyEmailState({
    @Default(false) errorState,
    @Default(false) isloading,
    TextEditingController? otpController,
    @Default('') String email,
  }) = _VerifyEmailState;
}
