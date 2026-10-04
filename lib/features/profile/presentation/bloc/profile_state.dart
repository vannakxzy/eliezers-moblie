part of 'profile_bloc.dart';

@freezed
class ProfileState extends BaseState with _$ProfileState {
  const factory ProfileState.initial({
    @Default(true) bool getProfileLoading,
    @Default(ProfileEntity()) ProfileEntity profileEntity,
    SettingEntity? setting,
    @Default([]) List<QuestionEntity> question,
    @Default([]) List<AnswertEntity> answer,
    @Default([]) List<TopTagEntity> toptag,
    @Default(true) loadingGetToptag,
    @Default(true) loadingAnswer,
    @Default(true) loadingQuestion,
    @Default(true) loadingSetting,
    @Default(false) isNothing,
  }) = _Initial;
}
