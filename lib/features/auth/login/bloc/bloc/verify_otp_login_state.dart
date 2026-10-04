part of 'verify_otp_login_bloc.dart';

@freezed
class VerifyOtpLoginState extends BaseState with _$VerifyOtpLoginState {
  const factory VerifyOtpLoginState.initial({
    @Default('') String email,
    @Default(false) errorState,
    @Default(false) bool isloading,
    TextEditingController? otpController,
  }) = _Initial;
}
