part of 'band_active_bloc.dart';

@freezed
class bandActiveState extends BaseState with _$bandActiveState {
  const factory bandActiveState.initial({
    @Default([]) List<BandEntity> band,
    @Default(true) bool isLoading,
    @Default(true) bool isMorePage,
    @Default(1) int page,
    @Default('active') String status,
  }) = _Initial;
}
