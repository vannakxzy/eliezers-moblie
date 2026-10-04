part of 'login_bloc.dart';

@freezed
class LoginState extends BaseState with _$LoginState {
  const factory LoginState({
    @Default(false) bool loading,
    @Default(false) bool enableLogin,
    @Default('') String email,
    @Default('') String password,
    String? emailError,
    String? passwordError,
  }) = _Initial;
}
