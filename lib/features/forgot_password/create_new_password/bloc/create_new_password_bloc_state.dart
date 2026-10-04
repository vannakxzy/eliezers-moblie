part of 'create_new_password_bloc_bloc.dart';

@freezed
class CreateNewPasswordBlocState extends BaseState
    with _$CreateNewPasswordBlocState {
  const factory CreateNewPasswordBlocState({
    @Default('') String password,
    @Default('') String email,
    @Default(false) bool isloading,
  }) = _Initial;
}
