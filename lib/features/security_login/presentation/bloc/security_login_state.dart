part of 'security_login_bloc.dart';

@freezed
class SecurityLoginState extends BaseState with _$SecurityLoginState {
  const factory SecurityLoginState.initial({
    @Default(false) bool deleteLoaing,
    @Default(false) bool logoutLoading,
  }) = _Initial;
}
