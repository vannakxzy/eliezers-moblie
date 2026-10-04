part of 'select_avtar_bloc.dart';

@freezed
class SelectAvatarState extends BaseState with _$SelectAvatarState {
  const factory SelectAvatarState.initial({
    @Default([]) List<AvartaEntity> avatar,
    @Default(false) bool isLoadin,
    @Default(false) bool submitLoading,
    @Default(0) int selectedIndex,
  }) = _Initial;
}
