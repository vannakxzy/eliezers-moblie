part of 'privacy_data_bloc.dart';

@freezed
class PrivacyDataState extends BaseState with _$PrivacyDataState {
  const factory PrivacyDataState({
    SettingEntity? setting,
    @Default(true) bool loading,
  }) = _PrivacyDataState;
}
