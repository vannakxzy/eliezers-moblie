part of 'verify_otp_change_password_bloc.dart';

@freezed
class VerifyOtpChangePasswordState extends BaseState
    with _$VerifyOtpChangePasswordState {
  const factory VerifyOtpChangePasswordState.initial({
    @Default(false) bool isloading,
    @Default(false) bool errorState,
  }) = _Initial;
}
