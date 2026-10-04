part of 'login_bloc.dart';

@freezed
class LoginState extends BaseState with _$LoginState {
  const factory LoginState({
    @Default(false) bool loading,
    @Default(false) bool enableLogin,
    @Default(false) bool loadingGmail,
    @Default(true) bool showPassword,
    @Default('') String email,
    @Default('') String password,
    String? emailError,
    String? passwordError,
  }) = _LoginState;
}

extension LoginExtention on LoginState {
  bool get validEmail => email.isNotEmpty && checkStringIsgmail(value: email);

  bool get validPassword => password.length >= 8;

  bool get validLogin => validEmail && validPassword;
}
