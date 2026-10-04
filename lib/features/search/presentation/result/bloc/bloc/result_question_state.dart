part of 'result_question_bloc.dart';

@freezed
class ResultQuestionState extends BaseState with _$ResultQuestionState {
  factory ResultQuestionState({
    @Default([]) List<QuestionEntity> questions,
    @Default([]) List<QuestionEntity> recentSearch,
    @Default(1) int page,
    @Default(false) bool loaingQuestion,
    @Default(false) bool isAnonyMous,
    @Default('') String kk,
    @Default(true) bool isMorePage,
  }) = _Initial;
}
