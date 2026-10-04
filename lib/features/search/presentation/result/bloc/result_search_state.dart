part of 'result_search_bloc.dart';

@freezed
class ResultSearchState extends BaseState with _$ResultSearchState {
  const factory ResultSearchState.initial({
    @Default("") String textSearch,
    @Default([]) List<String> recentSearch,
    @Default(FilterEntity()) FilterEntity filter,
    @Default(0) int filterCount,
    TextEditingController? textSearchController,
    @Default([]) List<BandEntity> band,
    @Default([]) List<ProfileEntity> profile,
    @Default([]) List<QuestionEntity> questions,
    @Default([]) List<AnswertEntity> answer,
    @Default([]) List<TagEntity> tags,
  }) = _Initial;
}
