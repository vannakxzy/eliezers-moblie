part of 'search_band_bloc.dart';

@freezed
class SearchBandState extends BaseState with _$SearchBandState {
  const factory SearchBandState.initial({
    @Default(true) bool isLoading,
    @Default('') String searchText,
    @Default(false) bool focusNode,
    @Default(false) bool showAllHistories,
    @Default(1) int page,
    @Default(true) bool isMorePage,
    @Default([]) List<String> recentSearch,
    @Default([]) List<BandEntity> band,
  }) = _Initial;
}
