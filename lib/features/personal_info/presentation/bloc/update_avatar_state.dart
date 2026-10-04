part of 'update_avatar_bloc.dart';

@freezed
class UpdateAvatarState extends BaseState with _$UpdateAvatarState {
  const factory UpdateAvatarState({
    @Default([]) List<AvartaEntity> avatar,
    @Default(false) bool isLoadin,
    @Default(-1) int selectedIndex,
  }) = _UpdateAvatarState;
}
