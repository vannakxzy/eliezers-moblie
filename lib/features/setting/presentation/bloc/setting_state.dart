part of 'setting_bloc.dart';

@freezed
class SettingState extends BaseState with _$SettingState {
  const factory SettingState({
    SettingEntity? setting,
    @Default(true) bool isloading,
  }) = _Initial;
}


