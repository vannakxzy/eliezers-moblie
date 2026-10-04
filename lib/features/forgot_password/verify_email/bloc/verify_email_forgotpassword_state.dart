part of 'verify_email_forgotpassword_bloc.dart';

@freezed
class VerifyEmailForgotpasswordState extends BaseState
    with _$VerifyEmailForgotpasswordState {
  const factory VerifyEmailForgotpasswordState({
    @Default(false) errorState,
    TextEditingController? otpController,
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isloading,
  }) = _VerifyEmailForgotpasswordState;
}
