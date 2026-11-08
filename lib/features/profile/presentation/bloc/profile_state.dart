part of 'profile_bloc.dart';

@freezed
class ProfileState extends BaseState with _$ProfileState {
  const factory ProfileState.initial({
    @Default(true) bool getProfileLoading,
    @Default(ProfileEntity()) ProfileEntity profileEntity,
    @Default(false) isNothing,
  }) = _Initial;
}
