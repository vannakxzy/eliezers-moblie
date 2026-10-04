part of 'change_password_bloc.dart';

@freezed
class ChangePasswordState extends BaseState with _$ChangePasswordState {
  const factory ChangePasswordState({
    @Default('') String newPassword,
    @Default(false) bool enableButton,
  }) = _ChangePasswordState;
}
