part of 'create_account_bloc.dart';

@freezed
class CreateAccountState extends BaseState with _$CreateAccountState {
  const factory CreateAccountState({
    @Default('') String email,
    @Default('') String name,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(true) bool validateButton,
    @Default(false) bool emailTaken,
  }) = _Initial;
}
