part of 'verify_email_createaccount_bloc.dart';

@freezed
class VerifyEmailCreateaccountState extends BaseState
    with _$VerifyEmailCreateaccountState {
  const factory VerifyEmailCreateaccountState({
    @Default(false) errorState,
    @Default(false) bool isloading,
    TextEditingController? otpController,
    @Default('') String email,
  }) = _VerifyEmailCreateaccountState;
}
