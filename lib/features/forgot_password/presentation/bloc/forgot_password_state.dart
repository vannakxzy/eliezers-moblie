part of 'forgot_password_bloc.dart';

@freezed
class ForgotPasswordState extends BaseState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default('') String email,
    @Default(false) bool isLoading,
    @Default(false) bool isToken,
  }) = _Initial;
}
