part of 'create_user_info_bloc.dart';

@freezed
class CreateUserInfoState extends BaseState with _$CreateUserInfoState {
  const factory CreateUserInfoState({
    @Default('') String email,
    @Default('') String otp,
    @Default('') String name,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(false) bool showPassword,
    @Default(false) bool showConfirmPassword,
    @Default(false) bool confirmTnC,
    @Default(false) bool isLoading,
  }) = _CreateUserInfoState;
}

extension CreateUserInfoStateExt on CreateUserInfoState {
  bool get enableButton =>
      password.length >= 8 &&
      confirmPassword.length >= 8 &&
      password == confirmPassword &&
      confirmTnC == true &&
      name.isNotEmptyOrNull;
}
