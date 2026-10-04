part of 'reset_password_bloc.dart';

@freezed
class ResetPasswordState extends BaseState with _$ResetPasswordState {
  const factory ResetPasswordState.initial({
    @Default(false) bool isloading,
    @Default('') String password,
    @Default(false) bool enableButton,
  }) = _Initial;
}

extension ResetPasswordStateExt on ResetPasswordState {
  bool get enableButton => password.length >= 8;
}
