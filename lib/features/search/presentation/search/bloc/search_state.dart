part of 'search_bloc.dart';

@freezed
class SearchState extends BaseState with _$SearchState {
  const factory SearchState({
    @Default(true) bool isloading,
    @Default('') String searchText,
    @Default(false) bool focusNode,
    @Default(false) bool showAllHistories,
    @Default([]) List<String> recentSearch,
    @Default([]) List<PopularSearchEntity> popularSearch,
  }) = _SearchState;
}
