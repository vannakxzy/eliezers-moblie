part of 'result_discussion_bloc.dart';

@freezed
class ResultDiscussionState extends BaseState with _$ResultDiscussionState {
  factory ResultDiscussionState({
    @Default([]) List<QuestionEntity> questions,
    @Default([]) List<QuestionEntity> recentSearch,
    @Default(1) int page,
    @Default(false) bool loaingQuestion,
    @Default(false) bool isAnonyMous,
    @Default('') String kk,
    @Default(true) bool isMorePage,
  }) = _Initial;
}
