part of 'hide_bloc.dart';

@freezed
class HideState extends BaseState with _$HideState {
  const factory HideState({
    @Default([]) List<HideEntity> hides,
    @Default(false) bool isLoading,
    @Default(1) int page,
    @Default(true) bool isMorePage,
  }) = _HideState;
}
