part of 'band_bloc.dart';

@freezed
class BandState extends BaseState with _$BandState {
  const factory BandState.initial({
    @Default([]) List<BandEntity> band,
    @Default(true) bool isLoading,
    @Default(true) bool isMorePage,
    @Default(1) int page,
    @Default(0) int pageIndex,
  }) = _Initial;
}
