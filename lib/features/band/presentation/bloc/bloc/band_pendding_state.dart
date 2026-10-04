part of 'band_pendding_bloc.dart';

@freezed
class bandPenddingState extends BaseState with _$bandPenddingState {
  const factory bandPenddingState.initial({
    @Default([]) List<BandEntity> band,
    @Default(true) bool isLoading,
    @Default(true) bool isMorePage,
    @Default('pendding') String status,
    @Default(1) int page,
  }) = _Initial;
}
