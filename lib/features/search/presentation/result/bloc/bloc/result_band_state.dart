part of 'result_band_bloc.dart';

@freezed
class ResultBandState extends BaseState with _$ResultBandState {
  const factory ResultBandState.initial({
    @Default([]) List<BandEntity> band,
    @Default([]) List<BandEntity> recentSearch,
    @Default(false) bool isLoading,
    @Default(true) bool isMorePage,
    @Default(1) int page,
  }) = _Initial;
}
