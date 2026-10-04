part of 'all_question_bloc.dart';

@freezed
class AllQuestionState extends BaseState with _$AllQuestionState {
  const factory AllQuestionState({
    @Default(false) bool isLoading,
    @Default([]) List<QuestionEntity> questions,
    @Default(true) bool isMorePage,
    @Default(1) int page,
  }) = _AllQuestionState;
}
